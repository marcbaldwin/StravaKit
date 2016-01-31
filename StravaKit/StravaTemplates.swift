import URITemplate

internal class StravaApiTemplate {

    private let url = "https://www.strava.com/"

    private lazy var api: String = self.url + "api/v3/"
    private lazy var athleteActivitiesTemplate: String = self.api + "athlete/activities"
    private lazy var streamsTemplate: URITemplate = URITemplate(template: self.api + "activities/{id}/streams/{types}")

    func athleteAcitvities() -> String {
        return athleteActivitiesTemplate
    }

    func activityStream(id: Int, types: [StreamType]) -> String {
        let typeString = types.reduce("") { $0.0 + $0.1.rawValue + "," }
        return streamsTemplate.expand(["id" : id, "types" : typeString])
    }
}

struct StravaAuthorizationTemplate {

    private let url = "https://www.strava.com/oauth/"
    private let requestAccessTemplate = "authorize?client_id={clientId}&response_type=code&redirect_uri={redirectURI}"
    private let tokenExchangeTemplate = "token"

    func requestAccess(clientId clientId: String, redirectUri: String) -> String {
        let variables = ["clientId" : clientId, "redirectURI" : redirectUri]
        return URITemplate(template: url + requestAccessTemplate).expand(variables)
    }

    func exchangeToken() -> String {
        return url + tokenExchangeTemplate
    }
}