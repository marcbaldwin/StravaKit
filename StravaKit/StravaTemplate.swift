import URITemplate

class StravaTemplate {

    private let url = "https://www.strava.com/"

    private lazy var authorizeTemplate = "oauth/authorize?client_id={clientId}&response_type=code&redirect_uri={redirectURI}"
    private let tokenExchangeTemplate = "oauth/token"

    private lazy var api: String = self.url + "api/v3/"
    private lazy var athleteActivitiesTemplate: String = self.api + "athlete/activities"
    private lazy var streamsTemplate: URITemplate = URITemplate(template: self.api + "activities/{id}/streams/{types}")

    func requestAccess(clientId clientId: String, redirectUri: String) -> String {
        let variables = ["clientId" : clientId, "redirectURI" : redirectUri]
        return URITemplate(template: url + authorizeTemplate).expand(variables)
    }

    func exchangeToken() -> String {
        return url + tokenExchangeTemplate
    }

    func athleteAcitvities() -> String {
        return athleteActivitiesTemplate
    }

    func activityStream(id: Int, types: [StreamType]) -> String {
        let typeString = types.reduce("") { $0.0 + $0.1.rawValue + "," }
        return streamsTemplate.expand(["id" : id, "types" : typeString])
    }
}