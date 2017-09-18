import Moya
import Alamofire

public enum StravaQuery {
    case page(Int)
    case before(Int)
    case after(Int)
}

public enum StravaApi {
    case athleteActivities(accessToken: String, query: [StravaQuery], size: Int)
}

extension StravaApi: TargetType {

    public var baseURL: URL {
        return URL(string: "https://www.strava.com/api/v3/")!
    }

    public var path: String {
        switch self {
        case .athleteActivities: return "athlete/activities"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var task: Task {
        switch self {
        case let .athleteActivities(accessToken, query, size):
            var params = [String : Any]()
            params["access_token"] = accessToken
            params["per_page"] = size
            for (key, value) in query.flatMap({ $0.parameters }) {
                params[key] = value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return nil
    }

    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
}

extension StravaQuery {

    public var parameters: [String : Any] {
        switch self {
        case let .page(page): return ["page" : page]
        case let .before(seconds): return ["before" : seconds]
        case let .after(seconds): return ["after" : seconds]
        }
    }
}
