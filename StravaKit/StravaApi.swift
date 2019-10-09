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
    case upload(accessToken: String, upload: ActivityUpload)
    case uploadStatus(accessToken: String, id: String)
}

extension StravaApi {

    var accessToken: String {
        switch self {
        case let .athlete(accessToken):
            return accessToken

        case let .athleteActivities(accessToken, _, _, _):
            return accessToken

        case let .athleteRoutes(accessToken, _, _):
            return accessToken

        case let .upload(accessToken, _):
            return accessToken

        case let .uploadStatus(accessToken, _):
            return accessToken
        }
    }
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

        case let .upload(accessToken, upload):
            var params = requestParameters(accessToken: accessToken)
            params["external_id"] = upload.externalId.utf16
            params["data_type"] = upload.dataType.utf16
            params["activity_type"] = upload.activityType.utf16

            let multipartFormData = [
                MultipartFormData(
                    provider: .file(upload.url),
                    name: "file",
                    fileName: upload.fileName,
                    mimeType: upload.mimeType
                )
            ]
            return .uploadCompositeMultipart(multipartFormData, urlParameters: params)

        case let .uploadStatus(accessToken, _):
            let params = requestParameters(accessToken: accessToken)
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return ["Authorization": "Bearer \(accessToken)"]
    }

    public var sampleData: Data {
        fatalError()
    }

    private func requestParameters(accessToken: String) -> [String : Any] {
        return ["access_token": accessToken]
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
        case let .before(seconds): return ["before": seconds]
        case let .after(seconds): return ["after": seconds]
        }
    }
}
