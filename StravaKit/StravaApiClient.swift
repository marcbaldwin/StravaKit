import Moya
import RxSwift

public final class StravaApiClient {

    public var onError: ((Error) -> Void)?

    private let stravaApi = MoyaProvider<StravaApi>()
    private let stravaAuthClient: StravaAuthApiClient

    public init(stravaAuthClient: StravaAuthApiClient) {
        self.stravaAuthClient = stravaAuthClient
    }

    public func athlete(auth: AuthDetails) -> Single<Athlete> {
        return request(auth: auth, type: Athlete.self) { accessToken in
            .athlete(accessToken: accessToken)
        }
    }

    public func athleteActivities(auth: AuthDetails, query: [StravaQuery], page: Int, pageSize: Int) -> Single<[Activity]> {
        return request(auth: auth, type: [Activity].self) { accessToken in
            .athleteActivities(accessToken: accessToken, query: query, page: page, pageSize: pageSize)
        }
    }

    public func athleteRoutes(auth: AuthDetails, page: Int, pageSize: Int) -> Single<[Route]> {
        return request(auth: auth, type: [Route].self) { accessToken in
            .athleteRoutes(accessToken: accessToken, page: page, pageSize: pageSize)
        }
    }

    public func routeGpx(auth: AuthDetails, id: Int64) -> Single<Data> {
        return request(auth: auth) { accessToken in
            .routeGpx(accessToken: accessToken, id: id)
        }
    }

    public func uploadActivity(auth: AuthDetails, upload: ActivityUpload) -> Single<ActivityUploadStatus> {
        return request(auth: auth, type: ActivityUploadStatus.self) { accessToken in
            .upload(accessToken: accessToken, upload: upload)
        }
    }

    public func uploadActivityStatus(auth: AuthDetails, id: String) -> Single<ActivityUploadStatus> {
        return request(auth: auth, type: ActivityUploadStatus.self) { accessToken in
            .uploadStatus(accessToken: accessToken, id: id)
        }
    }

    private func request<T: Decodable>(auth: AuthDetails, type: T.Type, _ request: @escaping (String) -> StravaApi) -> Single<T> {
        self.request(auth: auth, request).map { data in try JSONDecoder().decode(type, from: data) }
    }

    private func request(auth: AuthDetails, _ request: @escaping (String) -> StravaApi) -> Single<Data> {
        return stravaAuthClient.accessToken(authDetails: auth)
            .flatMap { accessToken in self.stravaApi.rx.request(request(accessToken)) }
            .map { response in try response.decode() }
            .catch { error -> Single<Data> in
                guard let stravaError = error as? StravaError, stravaError == .accessTokenInvalid else {
                    return .error(error)
                }
                return self.stravaAuthClient.refreshAccessToken(refreshToken: auth.refreshToken)
                    .flatMap { accessToken in self.stravaApi.rx.request(request(accessToken)) }
                    .map { response in try response.decode() }
            }
            .do(onError: { [weak self] error in self?.onError?(error) })
    }
}
