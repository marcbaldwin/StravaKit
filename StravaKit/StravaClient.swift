
public struct StravaClient {

    public let accessToken: String
    private let api = StravaApiTemplate()

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}

public extension StravaClient { // MARK: Activities

    /// Returns a list of activities for the authenticated user
    func athleteAcitvities(from from: NSDate, to: NSDate, handler: (Response<[Activity]>)->Void) {
        let parameters = builder().add("before", to.timeIntervalSince1970).add("after", from.timeIntervalSince1970)
        Request.request(url: api.athleteAcitvities(), parameters: parameters, transformer: { $0.activities }, handler: handler)
    }

    /// Returns a list of activities for the authenticated user
    func athleteAcitvities(page page: Int, pageSize: Int, handler: (Response<[Activity]>)->Void) {
        let parameters = builder().add("page", page).add("per_page", pageSize)
        Request.request(url: api.athleteAcitvities(), parameters: parameters, transformer: { $0.activities }, handler: handler)
    }

    /// Returns the stream of an activity belonging to the authenticated user
    func activityStreamForActivityWithId(id: Int, types: [StreamType], handler: (Response<Stream>)->Void) {
        let parameters = builder().add("resolution", "low")
        Request.request(url: api.activityStream(id, types: types), parameters: parameters, transformer: { $0.activityStream }, handler: handler)
    }
}

private extension StravaClient {

    private func builder() -> Parameters {
        return Parameters().add("access_token", accessToken)
    }
}