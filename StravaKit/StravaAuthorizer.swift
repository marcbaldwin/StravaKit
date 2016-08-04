/// Classes that need to be notified when the user is successfully authorized should implement this protocol
public protocol StravaAuthorizerDelegate: class {

    func didAuthorizeAthlete(athlete: Athlete?, withAccessToken accessToken: String)
}

/// Class that performs token exchange with Strava
public class StravaAuthorizer {

    public weak var delegate: StravaAuthorizerDelegate?

    public let clientId: String
    public let clientSecret: String
    private let template = StravaAuthorizationTemplate()

    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    public func requestAccessUrlWithRedirectUrl(url: String) -> NSURL {
        return template.requestAccess(clientId: clientId, redirectUri: url).URL!
    }

    public func authorizeWithUrl(url: NSURL) {
        if let code = url.params["code"] {
            exchangeTokenWithAuthorizationCode(code)
        }
    }

    public func exchangeTokenWithAuthorizationCode(authorizationCode: String) {
        let parameters = Parameters()
            .add("client_id", clientId)
            .add("client_secret", clientSecret)
            .add("code", authorizationCode)

        Request.request(.POST, url: template.exchangeToken(), parameters: parameters, transformer: { json in
                return (json["access_token"].string!, json["athlete"].athlete)
            }) { [unowned self] response in
                switch response {
                case .Success(let (accessToken, athlete)):
                    self.delegate?.didAuthorizeAthlete(athlete, withAccessToken: accessToken)
                case .Failure(_): break
                }
            }
    }
}