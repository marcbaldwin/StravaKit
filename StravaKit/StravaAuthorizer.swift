import Alamofire

/// Classes that need to be notified when the user is successfully authorized should implement this protocol
public protocol StravaAuthorizerDelegate: class {

    func didAuthorizeAthlete(_ athlete: Athlete?, withAccessToken accessToken: String)
}

/// Class that performs token exchange with Strava
open class StravaAuthorizer {

    open weak var delegate: StravaAuthorizerDelegate?

    open let clientId: String
    open let clientSecret: String
    fileprivate let template = StravaAuthorizationTemplate()

    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    open func requestAccessUrlWithRedirectUrl(_ url: String) -> URL {
        return template.requestAccess(clientId: clientId, redirectUri: url).URL! as URL
    }

    open func authorizeWithUrl(_ url: URL) {
        if let code = url.params["code"] {
            exchangeTokenWithAuthorizationCode(code)
        }
    }

    open func exchangeTokenWithAuthorizationCode(_ authorizationCode: String) {
        let parameters = Parameters()
            .add("client_id", clientId as AnyObject)
            .add("client_secret", clientSecret as AnyObject)
            .add("code", authorizationCode as AnyObject)

        Request.request(.post, url: template.exchangeToken(), parameters: parameters, transformer: { json in
                return (json["access_token"].string!, json["athlete"].athlete)
            }) { [unowned self] response in
                switch response {
                case .success(let (accessToken, athlete)):
                    self.delegate?.didAuthorizeAthlete(athlete, withAccessToken: accessToken)
                case .failure(_): break
                }
            }
    }
}
