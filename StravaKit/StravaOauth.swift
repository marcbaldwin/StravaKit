import Moya
import Alamofire

public enum StravaOauth {
    case token(clientId: String, clientSecret: String, code: String)

    public static func authorize(clientId: String, redirectUri: String, alwaysShowAuthorizationPrompt: Bool = false) -> URL {
        return URL(string: "https://www.strava.com/oauth/authorize?response_type=code"
            + "&client_id=\(clientId)"
            + "&redirect_uri=\(redirectUri)"
            + "&approval_prompt=\(alwaysShowAuthorizationPrompt ? "force" : "auto")"
        )!
    }
}

extension StravaOauth: TargetType {

    public var baseURL: URL {
        return URL(string: "https://www.strava.com/oauth/")!
    }

    public var path: String {
        switch self {
        case .token: return "token"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .token: return .post
        }
    }

    public var task: Task {
        switch self {
        case let .token(clientId, clientSecret, code):
            let params = ["client_id" : clientId, "client_secret" : clientSecret, "code" : code]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return nil
    }

    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
}
