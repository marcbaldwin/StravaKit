import Moya
import Alamofire

public enum StravaOauth {
    case token(clientId: String, clientSecret: String, code: String)

    public static func authorize(clientId: String, redirectUri: String) -> URL {
        return URL(string: "https://www.strava.com/oauth/authorize?response_type=code"
            + "&client_id=\(clientId)"
            + "&redirect_uri=\(redirectUri)"
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

    public var parameters: [String : Any]? {
        switch self {
        case let .token(clientId, clientSecret, code):
            return ["client_id" : clientId, "client_secret" : clientSecret, "code" : code]
        }
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    public var task: Task {
        return .request
    }

    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
}
