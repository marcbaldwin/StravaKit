
public struct StravaClient {

    let accessToken: String
    private let api = StravaApiTemplate()
}

public extension StravaClient { // MARK: Activities

    func activitiesForLocalAthlete(from: NSDate, to: NSDate) -> Request<[Activity]> {
        let parameters = builder().add("before", to.timeIntervalSince1970).add("after", from.timeIntervalSince1970)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { $0.activities }
    }

    func activities(page page: Int, pageSize: Int) -> Request<[Activity]> {
        let parameters = builder().add("page", page).add("per_page", pageSize)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { $0.activities }
    }

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