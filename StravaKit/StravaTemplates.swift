import URITemplate

internal class StravaApiTemplate {

    fileprivate let url = "https://www.strava.com/"

    fileprivate lazy var api: String = self.url + "api/v3/"
    fileprivate lazy var streamsTemplate: URITemplate = URITemplate(template: self.api + "activities/{id}/streams/{types}")

    func athleteAcitvities() -> String {
        return api + "athlete/activities"
    }

    func activityStream(_ id: Int, types: [StreamType]) -> String {
        let typeString = types.reduce("") { $0.0 + $0.1.rawValue + "," }
        return streamsTemplate.expand(["id" : id, "types" : typeString])
    }
}

struct StravaAuthorizationTemplate {

    fileprivate let url = "https://www.strava.com/oauth/"
    fileprivate let requestAccessTemplate = "authorize?client_id={clientId}&response_type=code&redirect_uri={redirectURI}"
    fileprivate let tokenExchangeTemplate = "token"

    func requestAccess(clientId: String, redirectUri: String) -> String {
        let variables = ["clientId" : clientId, "redirectURI" : redirectUri]
        return URITemplate(template: url + requestAccessTemplate).expand(variables)
    }

    func exchangeToken() -> String {
        return url + tokenExchangeTemplate
    }
}
