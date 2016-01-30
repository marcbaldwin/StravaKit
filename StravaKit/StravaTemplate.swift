import URITemplate

class StravaTemplate {

    private let url = "https://www.strava.com/api/v3/"
    private lazy var athleteActivitiesTemplate: String = self.url + "athlete/activities"
    private lazy var streamsTemplate: URITemplate = URITemplate(template: self.url + "activities/{id}/streams/{types}")

    func athleteAcitvities() -> String {
        return athleteActivitiesTemplate
    }

    func activityStream(id: Int, types: [StreamType]) -> String {
        let typeString = types.reduce("") { $0.0 + $0.1.rawValue + "," }
        return streamsTemplate.expand(["id" : id, "types" : typeString])
    }
}