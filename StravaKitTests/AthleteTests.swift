import XCTest
import Nimble
@testable import StravaKit

class AthleteTests: XCTestCase {

    func test_decode_athlete() throws {
        let jsonString = """
        {
            "profile": "https://dgalywyr863hv.cloudfront.net/pictures/athletes/1461461/751331/2/large.jpg",
            "badge_type_id": 0,
            "athlete_type": 0,
            "follower_count": 53,
            "friend_count": 53,
            "country": "United Kingdom",
            "mutual_friend_count": 0,
            "state": "",
            "friend": null,
            "shoes": [],
            "measurement_preference": "meters",
            "profile_medium": "https://dgalywyr863hv.cloudfront.net/pictures/athletes/1461461/751331/2/medium.jpg",
            "follower": null,
            "bikes": [
                      {
                      "name": "BMC TeamMachine SLR02",
                      "id": "b1245722",
                      "resource_state": 2,
                      "distance": 16985291,
                      "primary": true
                      },
                      {
                      "name": "Rental",
                      "id": "b1260849",
                      "resource_state": 2,
                      "distance": 1548722,
                      "primary": false
                      },
                      {
                      "name": "Trek 1.2",
                      "id": "b1245733",
                      "resource_state": 2,
                      "distance": 2876223,
                      "primary": false
                      }
                      ],
            "created_at": "2012-12-18T13:05:17Z",
            "ftp": null,
            "city": "Christchurch",
            "username": "marc_baldwin",
            "updated_at": "2016-05-26T20:08:23Z",
            "lastname": "Baldwin",
            "firstname": "Marc",
            "premium": false,
            "weight": 75,
            "resource_state": 3,
            "sex": "M",
            "date_preference": "%m/%d/%Y",
            "id": 1461461,
            "clubs": [
                      {
                      "cover_photo": null,
                      "resource_state": 2,
                      "id": 126996,
                      "name": "Mallorca 312 Crew",
                      "profile": "https://dgalywyr863hv.cloudfront.net/pictures/clubs/126996/2445469/2/large.jpg",
                      "member_count": 5,
                      "profile_medium": "https://dgalywyr863hv.cloudfront.net/pictures/clubs/126996/2445469/2/medium.jpg",
                      "featured": false,
                      "sport_type": "cycling"
                      },
                      {
                      "cover_photo": null,
                      "resource_state": 2,
                      "id": 191152,
                      "name": "LES ALPS 2016",
                      "profile": "https://dgalywyr863hv.cloudfront.net/pictures/clubs/191152/4060617/1/large.jpg",
                      "member_count": 11,
                      "profile_medium": "https://dgalywyr863hv.cloudfront.net/pictures/clubs/191152/4060617/1/medium.jpg",
                      "featured": false,
                      "sport_type": "cycling"
                      }
                      ]
        }

        """
        let jsonData = jsonString.data(using: .utf8)!
        let athlete = try JSONDecoder().decode(Athlete.self, from: jsonData)

        expect(athlete.id) == 1461461
        expect(athlete.firstName) == "Marc"
        expect(athlete.lastName) == "Baldwin"
        expect(athlete.country) == "United Kingdom"
        expect(athlete.hasPremium) == false
        expect(athlete.measurementPreference) == MeasurementPreference.meters
    }
}
