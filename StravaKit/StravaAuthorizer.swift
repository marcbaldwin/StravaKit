import Moya
import Alamofire

public enum StravaOauth {
    case authorize(clientId: String, redirectUri: String)
    case token(clientId: String, clientSecret: String, code: String)
}

extension StravaOauth: TargetType {

    public var baseURL: URL {
        return URL(string: "https://www.strava.com/oauth/")!
    }

    public var path: String {
        switch self {
        case .authorize: return "authorize"
        case .token: return "token"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var parameters: [String : Any]? {
        switch self {
        case let .authorize(clientId, redirectUri):
            return ["client_id" : clientId, "redirect_uri" : redirectUri, "response_type" : "code"]
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
