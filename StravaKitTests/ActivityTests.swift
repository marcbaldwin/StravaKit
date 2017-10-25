import XCTest
import Nimble
@testable import StravaKit

class ActivityTests: XCTestCase {

    func test_decode_activity() throws {
        let jsonString = """
        {
            "id": 8529483,
            "resource_state": 2,
            "external_id": "2013-08-23-17-04-12.fit",
            "upload_id": 84130503,
            "athlete": {
                "id": 227615,
                "resource_state": 1
            },
            "name": "08/23/2013 Oakland, CA",
            "distance": 32486.1,
            "moving_time": 5241,
            "elapsed_time": 5427,
            "total_elevation_gain": 566.0,
            "type": "Ride",
            "start_date": "2013-08-24T00:04:12Z",
            "start_date_local": "2013-08-23T17:04:12Z",
            "timezone": "(GMT-08:00) America/Los_Angeles",
            "start_latlng": [
                             37.793551,
                             -122.2686
                             ],
            "end_latlng": [
                           37.792836,
                           -122.268287
                           ],
            "location_city": "Oakland",
            "location_state": "CA",
            "location_country": "United States",
            "achievement_count": 8,
            "kudos_count": 0,
            "comment_count": 0,
            "athlete_count": 1,
            "photo_count": 0,
            "total_photo_count": 0,
            "map": {
                "id": "a77175935",
                "summary_polyline": "cetewLja@zYcG",
                "resource_state": 2
            },
            "trainer": false,
            "commute": false,
            "manual": false,
            "private": false,
            "flagged": false,
            "average_speed": 3.4,
            "max_speed": 4.514,
            "average_watts": 163.6,
            "weighted_average_watts": 200,
            "kilojoules": 857.6,
            "device_watts": true,
            "average_heartrate": 138.8,
            "max_heartrate": 179.0
        }
        """

        let jsonData = jsonString.data(using: .utf8)!
        let activity = try JSONDecoder().decode(Activity.self, from: jsonData)

        expect(activity.id) == 8529483
        expect(activity.name) == "08/23/2013 Oakland, CA"
        expect(activity.distance) == 32486.1
        expect(activity.movingTime) == 5241
        expect(activity.elapsedTime) == 5427
        expect(activity.totalElevationGain) == 566.0
        expect(activity.type) == "Ride"
        expect(activity.startDate) == "2013-08-24T00:04:12Z"
        expect(activity.localTimeZone) == "(GMT-08:00) America/Los_Angeles"
        expect(activity.map.summaryPolyline) == "cetewLja@zYcG"
        expect(activity.isStaticTrainer) == false
        expect(activity.isCommute) == false
        expect(activity.isManual) == false
        expect(activity.averageSpeed) == 3.4
        expect(activity.maxSpeed) == 4.514
        expect(activity.averageHeartRate) == 138.8
        expect(activity.maxHeartRate) == 179.0
    }
}
