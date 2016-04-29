
public struct StravaClient {

    public var accessToken: String?
    private let api = StravaApiTemplate()

    public init(accessToken: String? = nil) {
        self.accessToken = accessToken
    }
}

public extension StravaClient { // MARK: Activities

    /// Returns a list of activities within the specified date range for the authenticated user
    func athleteAcitvities(from from: NSDate, to: NSDate, handler: (Response<[Activity]>)->Void) {
        if let accessToken = accessToken {
            let parameters = builder(accessToken).add("before", to.timeIntervalSince1970).add("after", from.timeIntervalSince1970)
            Request.request(url: api.athleteAcitvities(), parameters: parameters, transformer: { $0.activities }, handler: handler)
        } else {
            handler(.Failure(.Unauthorized))
        }
    }

    /// Returns a list of activities for the authenticated user
    func athleteAcitvities(page page: Int, pageSize: Int, handler: (Response<[Activity]>)->Void) {
        if let accessToken = accessToken {
            let parameters = builder(accessToken).add("page", page).add("per_page", pageSize)
            Request.request(url: api.athleteAcitvities(), parameters: parameters, transformer: { $0.activities }, handler: handler)
        } else {
            handler(.Failure(.Unauthorized))
        }
    }

}

private extension StravaClient { // MARK: Activity

    /// Returns the stream of an activity belonging to the authenticated user
    func activityStreamForActivityWithId(id: Int, types: [StreamType], handler: (Response<Stream>)->Void) {
        if let accessToken = accessToken {
            let parameters = builder(accessToken).add("resolution", "low")
            Request.request(url: api.activityStream(id, types: types), parameters: parameters, transformer: { $0.activityStream }, handler: handler)
        } else {
            handler(.Failure(.Unauthorized))
        }
    }
}

private extension StravaClient {

    private func builder(accessToken: String) -> Parameters {
        return Parameters().add("access_token", accessToken)
    }
}