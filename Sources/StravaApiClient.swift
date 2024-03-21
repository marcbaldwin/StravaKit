import Alamofire
import Foundation

public final class StravaApiClient {

    public var onError: ((Error) -> Void)?

    private let baseURL = "https://www.strava.com/api/v3"
    private let stravaAuthClient: StravaAuthApiClient

    public init(stravaAuthClient: StravaAuthApiClient) {
        self.stravaAuthClient = stravaAuthClient
    }

    public func athlete(auth: AuthDetails) async throws -> Athlete {
        try await request(auth: auth, path: "athlete", type: Athlete.self)
    }

    public func athleteActivities(
        auth: AuthDetails,
        query: [StravaQuery],
        page: Int,
        pageSize: Int
    ) async throws -> [Activity] {
        var parameters: [String: Any] = [
            "page": page,
            "per_page": pageSize,
        ]
        for (key, value) in query.flatMap({ $0.parameters }) {
            parameters[key] = value
        }
        return try await request(auth: auth, path: "athlete/activities", parameters: parameters, type: [Activity].self)
    }

    public func athleteRoutes(auth: AuthDetails, page: Int, pageSize: Int) async throws -> [Route] {
        let parameters = [
            "page": page,
            "per_page": pageSize,
        ]
        return try await request(auth: auth, path: "athlete/routes", parameters: parameters, type: [Route].self)
    }

    public func routeGpx(auth: AuthDetails, id: Int64) async throws -> Data {
        try await nextRequest(auth: auth, path: "routes/\(id)/export_gpx")
    }

    private func request<T: Decodable>(
        auth: AuthDetails,
        path: String,
        parameters: Parameters = [:],
        type: T.Type
    ) async throws -> T {
        let data = try await nextRequest(auth: auth, path: path, parameters: parameters)
        return try JSONDecoder().decode(type, from: data)
    }

    private func nextRequest(
        auth: AuthDetails,
        path: String,
        parameters: Parameters = [:]
    ) async throws -> Data {
        do {
            let accessToken = try await stravaAuthClient.accessToken(authDetails: auth)
            return try await dataRequest(path: path, parameters: parameters, accessToken: accessToken)
        } catch let error {
            // Try to refresh access token
            guard let stravaError = error as? StravaError, stravaError == .accessTokenInvalid else {
                throw error
            }

            do {
                let accessToken = try await stravaAuthClient.refreshAccessToken(refreshToken: auth.refreshToken)
                return try await dataRequest(path: path, parameters: parameters, accessToken: accessToken)
            } catch let error {
                onError?(error)
                throw error
            }
        }
    }

    private func dataRequest(
        path: String,
        parameters: Parameters = [:],
        accessToken: String
    ) async throws -> Data {
        try await StravaKit.dataRequest(
            url: URL(string: "\(baseURL)/\(path)")!,
            method: .get,
            parameters: parameters,
            headers: ["Authorization": "Bearer \(accessToken)"]
        )
    }
}
