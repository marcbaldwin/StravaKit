import Moya
import RxSwift

public final class StravaAuthApiClient {

    public var onAuthDetailsRefreshed: ((AuthDetails) -> Void)? = nil

    private let authApi = MoyaProvider<StravaAuthApi>()
    private let clientId: String
    private let clientSecret: String

    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    public func authorizeUrl(redirectUri: String, alwaysShowAuthorizationPrompt: Bool = false, scope: String) -> URL {
        return URL(string: "https://www.strava.com/oauth/mobile/authorize?response_type=code"
            + "&client_id=\(clientId)"
            + "&redirect_uri=\(redirectUri)"
            + "&approval_prompt=\(alwaysShowAuthorizationPrompt ? "force" : "auto")"
            + "&scope=\(scope)"
        )!
    }

    public func authorize(url: URL) -> Single<AuthResponse> {
        guard let code = url.params["code"] else {
            let error = url.params["error"]
            switch error {
            case "access_denied":
                return .error(StravaError.authUserDeniedAccess)

            default:
                return .error(StravaError.authUnexpectedError(error))
            }
        }

        return authApi.rx
            .request(.authorize(clientId: clientId, clientSecret: clientSecret, code: code))
            .map { response in try response.decode(type: AuthResponse.self) }
    }

    public func accessToken(authDetails: AuthDetails) -> Single<String> {
        if authDetails.hasExpired {
            return refreshAccessToken(refreshToken: authDetails.refreshToken)
        } else {
            return Single.just(authDetails.accessToken)
        }
    }

    public func refreshAccessToken(refreshToken: String) -> Single<String> {
        return authApi.rx
            .request(.refreshToken(clientId: clientId, clientSecret: clientSecret, refreshToken: refreshToken))
            .map { response in try response.decode(type: AuthRefreshTokenResponse.self) }
            .do(onSuccess: { [weak self] response in
                self?.onAuthDetailsRefreshed?(response.authDetails)
            })
            .map { $0.accessToken }
    }
}
