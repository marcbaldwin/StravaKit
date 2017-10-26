import Moya
import Alamofire

public enum StravaQuery {
    case before(Int)
    case after(Int)
}

public enum StravaApi {
    case athlete(accessToken: String)
    case athleteActivities(accessToken: String, query: [StravaQuery], page: Int, pageSize: Int)
    case athleteRoutes(accessToken: String, page: Int, pageSize: Int)
}

extension StravaApi: TargetType {

    public var baseURL: URL {
        return URL(string: "https://www.strava.com/api/v3/")!
    }

    public var path: String {
        switch self {
        case .athlete: return "athlete"
        case .athleteActivities: return "athlete/activities"
        case .athleteRoutes: return "athlete/routes"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var task: Task {
        switch self {

        case let .athlete(accessToken):
            let params = requestParameters(accessToken: accessToken)
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

        case let .athleteActivities(accessToken, query, page, pageSize):
            var params = requestParameters(accessToken: accessToken, page: page, pageSize: pageSize)
            for (key, value) in query.flatMap({ $0.parameters }) {
                params[key] = value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

        case let .athleteRoutes(accessToken, page, pageSize):
            let params = requestParameters(accessToken: accessToken, page: page, pageSize: pageSize)
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return nil
    }

    public var sampleData: Data {
        return "".data(using: .utf8)!
    }

    private func requestParameters(accessToken: String) -> [String : Any] {
        return ["access_token" : accessToken]
    }

    private func requestParameters(accessToken: String, page: Int, pageSize: Int) -> [String : Any] {
        var params = requestParameters(accessToken: accessToken)
        params["page"] = page
        params["per_page"] = pageSize
        return params
    }
}

extension StravaQuery {

    public var parameters: [String : Any] {
        switch self {
        case let .before(seconds): return ["before" : seconds]
        case let .after(seconds): return ["after" : seconds]
        }
    }
}
