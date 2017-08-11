import Moya
import Alamofire

public enum StravaApi {
    case athleteActivities(accessToken: String, page: Int, size: Int)
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
        case let .athleteActivities(accessToken, page, size):
            return ["access_token" : accessToken, "page" : page, "per_page" : size]
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
