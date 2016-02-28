/// Classes that need to be notified when the user is successfully authorized should implement this protocol
public protocol StravaAuthorizerDelegate: class {

    func didAuthorizeAthleteWithAccessToken(accessToken: String)
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

    public func requestAccessWithRedirectURL(url: String) {
        UIApplication.sharedApplication().openURL(template.requestAccess(clientId: clientId, redirectUri: url).URL!)
    }

    public func authorizeWithURL(url: NSURL) {
        if let code = url.params["code"] {
            exchangeTokenWithAuthorizationCode(code)
        }
    }
}

private extension StravaAuthorizer {

    func exchangeTokenWithAuthorizationCode(authorizationCode: String) {
        let parameters = Parameters()
            .add("client_id", clientId)
            .add("client_secret", clientSecret)
            .add("code", authorizationCode)

        Request<(String, Athlete)>(method: .POST, url: template.exchangeToken(), parameters: parameters) { json in
                return (json["access_token"].string!, json["athlete"].athlete)
            }
            .onSuccess { [unowned self] accessToken, athlete in
                self.delegate?.didAuthorizeAthleteWithAccessToken(accessToken)
            }
    }
}