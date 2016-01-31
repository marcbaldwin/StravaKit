import Alamofire
import SwiftyJSON

typealias ErrorHandler = (NSError) -> ()

class StravaClient {

    private let clientId: String
    private let clientSecret: String
    private let api = StravaTemplate()

    var accessToken: String!

    init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    private func builder() -> Parameters {
        return Parameters().add("access_token", accessToken)
    }
}

extension StravaClient { // MARK: Authorization

    func requestAccessWithRedirectURL(url: String) {
        UIApplication.sharedApplication().openURL(api.requestAccess(clientId: clientId, redirectUri: url).URL!)
    }

    func exchangeToken(url: NSURL) -> Request<(String, Athlete)> {
        let parameters = Parameters()
            .add("client_id", clientId)
            .add("client_secret", clientSecret)
            .add("code", url.params["code"]!)

        return Request(method: .POST, url: api.exchangeToken(), parameters: parameters) { data in
            let json = JSON(data)
            return (json["access_token"].string!, json["athlete"].athlete)
        }
    }
}

extension StravaClient { // MARK: Activities

    func activitiesForLocalAthlete(from: NSDate, to: NSDate) -> Request<[Activity]> {
        let parameters = builder().add("before", to.timeIntervalSince1970).add("after", from.timeIntervalSince1970)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { JSON($0).activities }
    }

    func activities(page page: Int, pageSize: Int) -> Request<[Activity]> {
        let parameters = builder().add("page", page).add("per_page", pageSize)
        return Request(url: api.athleteAcitvities(), parameters: parameters) { JSON($0).activities }
    }

    func activityStreamForActivityWithId(id: Int, types: [StreamType]) ->Request<ActivityStream> {
        let parameters = builder().add("resolution", "low")
        return Request(url: api.activityStream(id, types: types), parameters: parameters) { JSON($0).activityStream }
    }
}