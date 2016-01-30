import SwiftyJSON

extension StravaClient {

    func activitiesForLocalAthlete(from: NSDate, to: NSDate) -> Request<[Activity]> {
        let parameters = self.parameters()
            .add("before", to.timeIntervalSince1970)
            .add("after", from.timeIntervalSince1970)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { JSON($0).activities }
    }

    func activities(page page: Int, pageSize: Int) -> Request<[Activity]> {
        let parameters = self.parameters().add("page", page).add("per_page", pageSize)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { JSON($0).activities }
    }

    func activityStreamForActivityWithId(id: Int, types: [StreamType]) ->Request<ActivityStream> {
        let parameters = self.parameters().add("resolution", "low")
        return Request(url: api.activityStream(id, types: types), parameters: parameters) { JSON($0).activityStream }
    }
}
