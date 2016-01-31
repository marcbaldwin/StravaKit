import Alamofire
import SwiftyJSON

typealias ErrorHandler = (NSError) -> ()

public class StravaClient {

    private let clientId: String
    private let clientSecret: String
    private let api = StravaTemplate()

    var accessToken: String!
    var athlete: Athlete!

    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    private func builder() -> Parameters {
        return Parameters().add("access_token", accessToken)
    }
}

public extension StravaClient { // MARK: Authorization

    func requestAccessWithRedirectURL(url: String) {
        UIApplication.sharedApplication().openURL(api.requestAccess(clientId: clientId, redirectUri: url).URL!)
    }

    func exchangeToken(url: NSURL) {
        let parameters = Parameters()
            .add("client_id", clientId)
            .add("client_secret", clientSecret)
            .add("code", url.params["code"]!)

        Request<(String, Athlete)>(method: .POST, url: api.exchangeToken(), parameters: parameters) { json in
                return (json["access_token"].string!, json["athlete"].athlete)
            }
            .onSuccess { accessToken, athlete in
                self.accessToken = accessToken
                self.athlete = athlete
            }
    }
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