import Alamofire
import SwiftyJSON

let RequestAccessState = "RequestAccessState"

typealias ErrorHandler = (NSError) -> ()

class StravaClient {

    let clientId: String
    let clientSecret: String
    var accessToken: String!

    var localAthlete: Athlete?

    let api = StravaTemplate()
    private let authorizeURLTemplate = "https://www.strava.com/oauth/authorize?client_id=%@&response_type=code&redirect_uri=%@&state=%@"
    private let tokenExchangeTemplate = "https://www.strava.com/oauth/token"

    init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    func requestAccessWithRedirectURL(url: String) {
        let authorizeURL = authorizeURLTemplate.format(clientId, url, RequestAccessState)
        UIApplication.sharedApplication().openURL(authorizeURL.URL!)
    }

    func handleRequestAccessCallbackWithURL(url: NSURL, success: ((Athlete) -> ())? = nil, failure: ErrorHandler? = nil) {

        let parameters = [
            "client_id" : clientId,
            "client_secret" : clientSecret,
            "code" : url.params["code"]!
        ]

        Alamofire
            .request(.POST, tokenExchangeTemplate, parameters: parameters)
            .responseJSON { response in
                let json = JSON(response.data!)
                self.accessToken = json["access_token"].string
                self.localAthlete = json["athlete"].athlete
                success?(self.localAthlete!)
            }
    }

    func parameters() -> Parameters {
        return Parameters().add("access_token", accessToken)
    }
}