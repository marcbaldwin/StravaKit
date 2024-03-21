import Alamofire
import Foundation

public final class StravaAuthApiClient {

    public var onAuthDetailsRefreshed: ((AuthDetails) -> Void)? = nil

    private let baseURL = "https://www.strava.com/oauth/token"
    private let clientId: String
    private let clientSecret: String

    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    public func authorizeUrl(
        redirectUri: String, 
        alwaysShowAuthorizationPrompt: Bool = false,
        scopes: StravaAuthScope...
    ) -> URL {
        URL(string: "https://www.strava.com/oauth/mobile/authorize?response_type=code"
            + "&client_id=\(clientId)"
            + "&redirect_uri=\(redirectUri)"
            + "&approval_prompt=\(alwaysShowAuthorizationPrompt ? "force" : "auto")"
            + "&scope=\(scopes.map({ $0.rawValue }).joined(separator: ","))"
        )!
    }

    public func authorize(url: URL) async throws -> (AuthResponse, [StravaAuthScope]) {
        guard let code = url.params["code"] else {
            let error = url.params["error"]
            switch error {
            case "access_denied": throw StravaError.authUserDeniedAccess
            default: throw StravaError.authUnexpectedError(error)
            }
        }

        let scopes = url.params["scope"]?
            .components(separatedBy: ",")
            .compactMap { StravaAuthScope(rawValue: $0) } ?? []

        let params = [
            "client_id" : clientId,
            "client_secret" : clientSecret,
            "code" : code,
            "grant_type": "authorization_code"
        ]

        let response = try await dataRequest(params: params, type: AuthResponse.self)
        return (response, scopes)
    }

    public func accessToken(authDetails: AuthDetails) async throws -> String {
        if authDetails.hasExpired {
            return try await refreshAccessToken(refreshToken: authDetails.refreshToken)
        } else {
            return authDetails.accessToken
        }
    }

    public func refreshAccessToken(refreshToken: String) async throws -> String {
        let params = [
            "client_id" : clientId,
            "client_secret" : clientSecret,
            "refresh_token": refreshToken,
            "grant_type": "refresh_token"
        ]

        let response = try await dataRequest(params: params, type: AuthRefreshTokenResponse.self)
        onAuthDetailsRefreshed?(response.authDetails)
        return response.accessToken
    }

    private func dataRequest<T: Decodable>(params: [String: Any] = [:], type: T.Type) async throws -> T {
        let data = try await StravaKit.dataRequest(
            url: URL(string: baseURL)!,
            method: .post,
            parameters: params
        )
        return try JSONDecoder().decode(type, from: data)
    }
}
