import Alamofire
import Foundation
import RxSwift

public final class StravaApiClient {

    public var onError: ((Error) -> Void)?

    private let baseURL = "https://www.strava.com/api/v3"
    private let stravaAuthClient: StravaAuthApiClient

    public init(stravaAuthClient: StravaAuthApiClient) {
        self.stravaAuthClient = stravaAuthClient
    }

    public func athlete(auth: AuthDetails) -> Single<Athlete> {
        request(auth: auth, path: "athlete", type: Athlete.self)
    }

    public func athleteActivities(auth: AuthDetails, query: [StravaQuery], page: Int, pageSize: Int) -> Single<[Activity]> {
        var parameters: [String: Any] = [
            "page": page,
            "per_page": pageSize,
        ]
        for (key, value) in query.flatMap({ $0.parameters }) {
            parameters[key] = value
        }
        return request(auth: auth, path: "athlete/activities", parameters: parameters, type: [Activity].self)
    }

    public func athleteRoutes(auth: AuthDetails, page: Int, pageSize: Int) -> Single<[Route]> {
        let parameters = [
            "page": page,
            "per_page": pageSize,
        ]
        return request(auth: auth, path: "athlete/routes", parameters: parameters, type: [Route].self)
    }

    public func routeGpx(auth: AuthDetails, id: Int64) -> Single<Data> {
        request(auth: auth, path: "routes/\(id)/export_gpx")
    }

    private func request<T: Decodable>(
        auth: AuthDetails,
        path: String,
        parameters: Parameters = [:],
        type: T.Type
    ) -> Single<T> {
        request(auth: auth, path: path, parameters: parameters)
            .map { data in try JSONDecoder().decode(type, from: data) }
    }

    private func request(
        auth: AuthDetails,
        path: String,
        parameters: Parameters = [:]
    ) -> Single<Data> {
        stravaAuthClient.accessToken(authDetails: auth)
            .flatMap { accessToken in
                self.dataRequest(path: path, parameters: parameters, accessToken: accessToken)
            }
            .catch { error -> Single<Data> in
                guard let stravaError = error as? StravaError, stravaError == .accessTokenInvalid else {
                    return .error(error)
                }
                return self.stravaAuthClient.refreshAccessToken(refreshToken: auth.refreshToken)
                    .flatMap { accessToken in
                        self.dataRequest(path: path, parameters: parameters, accessToken: accessToken)
                    }
            }
            .do(onError: { [weak self] error in self?.onError?(error) })
    }

    private func dataRequest(
        path: String,
        parameters: Parameters = [:],
        accessToken: String
    ) -> Single<Data> {

        Alamofire.Session.default
            .request(
                URL(string: "\(baseURL)/\(path)")!,
                method: .get,
                parameters: parameters,
                headers: ["Authorization": "Bearer \(accessToken)"]
            )
            .rx.responseData()
            .map { try $0.decode() }
    }
}
