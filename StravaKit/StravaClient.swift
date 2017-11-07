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
    case upload(accessToken: String, externalId: String, activityType: String, url: URL, fileName: String, dataType: String, mimeType: String)
    case uploadStatus(accessToken: String, id: String)
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
        case .upload: return "uploads"
        case let .uploadStatus(_, id): return "uploads/\(id)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .upload: return .post
        default: return .get
        }
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

        case let .upload(accessToken, externalId, activityType, url, fileName, dataType, mimeType):
            var params = requestParameters(accessToken: accessToken)
            params["external_id"] = externalId
            params["data_type"] = dataType
            params["activity_type"] = activityType
            let multipartFormData = [MultipartFormData(provider: .file(url), name: "file", fileName: fileName, mimeType: mimeType)]
            return .uploadCompositeMultipart(multipartFormData, urlParameters: params)

        case let .uploadStatus(accessToken, _):
            let params = requestParameters(accessToken: accessToken)
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
