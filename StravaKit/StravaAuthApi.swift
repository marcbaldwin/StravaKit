import Moya
import Alamofire

public enum StravaAuthApi {
    case authorize(clientId: String, clientSecret: String, code: String)
    case refreshToken(clientId: String, clientSecret: String, refreshToken: String)
}

extension StravaAuthApi: TargetType {

    public var baseURL: URL {
        return URL(string: "https://www.strava.com/oauth/")!
    }

    public var path: String {
        return "token"
    }

    public var method: Moya.Method {
        return .post
    }

    public var task: Task {
        switch self {
        case let .authorize(clientId, clientSecret, code):
            let params = [
                "client_id" : clientId,
                "client_secret" : clientSecret,
                "code" : code,
                "grant_type": "authorization_code"
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

        case let .refreshToken(clientId, clientSecret, refreshToken):
            let params = [
                "client_id" : clientId,
                "client_secret" : clientSecret,
                "refresh_token": refreshToken,
                "grant_type": "refresh_token"
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return nil
    }

    public var sampleData: Data {
        fatalError()
    }
}
