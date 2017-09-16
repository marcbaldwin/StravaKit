import Moya
import Alamofire

public enum StravaQuery {
    case page(Int)
    case before(Int)
    case after(Int)
}

public enum StravaApi {
    case athleteActivities(accessToken: String, query: StravaQuery, size: Int)
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

    public var parameters: [String : Any]? {
        switch self {
        case let .athleteActivities(accessToken, query, size):
            return ["access_token" : accessToken, query.key : query.value, "per_page" : size]
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

extension StravaQuery {

    public var key: String {
        switch self {
        case .page: return "page"
        case .before: return "before"
        case .after: return "after"
        }
    }

    public var value: Any {
        switch self {
        case let .page(page): return page
        case let .before(seconds): return seconds
        case let .after(seconds): return seconds
        }
    }
}
