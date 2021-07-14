import Alamofire
import RxSwift

public final class StravaAuthApiClient {

    public var onAuthDetailsRefreshed: ((AuthDetails) -> Void)? = nil

    private let baseURL = "https://www.strava.com/oauth/token"
    private let clientId: String
    private let clientSecret: String

    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    public func authorizeUrl(redirectUri: String, alwaysShowAuthorizationPrompt: Bool = false, scopes: StravaAuthScope...) -> URL {
        return URL(string: "https://www.strava.com/oauth/mobile/authorize?response_type=code"
            + "&client_id=\(clientId)"
            + "&redirect_uri=\(redirectUri)"
            + "&approval_prompt=\(alwaysShowAuthorizationPrompt ? "force" : "auto")"
            + "&scope=\(scopes.map({ $0.rawValue }).joined(separator: ","))"
        )!
    }

    public func authorize(url: URL) -> Single<(AuthResponse, [StravaAuthScope])> {
        guard let code = url.params["code"] else {
            let error = url.params["error"]
            switch error {
            case "access_denied":
                return .error(StravaError.authUserDeniedAccess)

            default:
                return .error(StravaError.authUnexpectedError(error))
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

        return dataRequest(params: params, type: AuthResponse.self)
            .map { response in (response, scopes) }
    }

    public func accessToken(authDetails: AuthDetails) -> Single<String> {
        if authDetails.hasExpired {
            return refreshAccessToken(refreshToken: authDetails.refreshToken)
        } else {
            return Single.just(authDetails.accessToken)
        }
    }

    public func refreshAccessToken(refreshToken: String) -> Single<String> {
        let params = [
            "client_id" : clientId,
            "client_secret" : clientSecret,
            "refresh_token": refreshToken,
            "grant_type": "refresh_token"
        ]

        return dataRequest(params: params, type: AuthRefreshTokenResponse.self)
            .do(onSuccess: { [weak self] response in
                self?.onAuthDetailsRefreshed?(response.authDetails)
            })
            .map { $0.accessToken }
    }

    private func dataRequest<T: Decodable>(params: [String: Any] = [:], type: T.Type) -> Single<T> {
        Alamofire.Session.default
            .request(
                URL(string: baseURL)!,
                method: .post,
                parameters: params
            )
            .rx.responseData()
            .map { try $0.decode(type: type) }
    }
}
