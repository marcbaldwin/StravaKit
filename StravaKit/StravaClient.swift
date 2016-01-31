
public struct StravaClient {

    public let accessToken: String
    private let api = StravaApiTemplate()

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}

public extension StravaClient { // MARK: Activities

    /// Returns a list of activities for the authenticated user
    func athleteAcitvities(from from: NSDate, to: NSDate) -> Request<[Activity]> {
        let parameters = builder().add("before", to.timeIntervalSince1970).add("after", from.timeIntervalSince1970)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { $0.activities }
    }

    /// Returns a list of activities for the authenticated user
    func athleteAcitvities(page page: Int, pageSize: Int) -> Request<[Activity]> {
        let parameters = builder().add("page", page).add("per_page", pageSize)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { $0.activities }
    }

    /// Returns the stream of an activity belonging to the authenticated user
    func activityStreamForActivityWithId(id: Int, types: [StreamType]) ->Request<Stream> {
        let parameters = builder().add("resolution", "low")
        return Request(url: api.activityStream(id, types: types), parameters: parameters) { $0.activityStream }
    }
}

private extension StravaClient {

    private func builder() -> Parameters {
        return Parameters().add("access_token", accessToken)
    }
}