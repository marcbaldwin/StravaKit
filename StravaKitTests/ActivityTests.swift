import XCTest
import Nimble
@testable import StravaKit

final class ActivityTests: XCTestCase {

    func test_decode_activity() throws {
        let jsonData = activityWithGpsJson.data(using: .utf8)!
        let activity = try JSONDecoder().decode(Activity.self, from: jsonData)

        expect(activity.id) == 8529483
        expect(activity.name) == "08/23/2013 Oakland, CA"
        expect(activity.distance) == 32486.1
        expect(activity.movingTime) == 5241
        expect(activity.elapsedTime) == 5427
        expect(activity.totalElevationGain) == 566.0
        expect(activity.type) == "Ride"
        expect(activity.startDate) == "2013-08-24T00:04:12Z"
        expect(activity.localStartDate) == "2013-08-23T17:04:12Z"
        expect(activity.localTimeZone) == "(GMT-08:00) America/Los_Angeles"
        expect(activity.start!.latitude) == 37.793551
        expect(activity.start!.longitude) == -122.2686
        expect(activity.end!.latitude) == 37.792836
        expect(activity.end!.longitude) == -122.268287
        expect(activity.map.summaryPolyline) == "cetewLja@zYcG"
        expect(activity.isStaticTrainer) == false
        expect(activity.isCommute) == false
        expect(activity.isManual) == false
        expect(activity.averageSpeed) == 3.4
        expect(activity.maxSpeed) == 4.514
        expect(activity.averageHeartRate) == 138.8
        expect(activity.maxHeartRate) == 179.0
    }

    func test_decode_activity_with_no_gps() throws {
        let jsonData = activityWithNoGpsJson.data(using: .utf8)!
        let activity = try JSONDecoder().decode(Activity.self, from: jsonData)

        expect(activity.id) == 8529483
        expect(activity.name) == "08/23/2013 Oakland, CA"
        expect(activity.distance) == 32486.1
        expect(activity.movingTime) == 5241
        expect(activity.elapsedTime) == 5427
        expect(activity.totalElevationGain) == 566.0
        expect(activity.type) == "Ride"
        expect(activity.startDate) == "2013-08-24T00:04:12Z"
        expect(activity.localStartDate) == "2013-08-23T17:04:12Z"
        expect(activity.localTimeZone) == "(GMT-08:00) America/Los_Angeles"
        expect(activity.start).to(beNil())
        expect(activity.end).to(beNil())
        expect(activity.map.summaryPolyline).to(beNil())
        expect(activity.isStaticTrainer) == false
        expect(activity.isCommute) == false
        expect(activity.isManual) == false
        expect(activity.averageSpeed) == 3.4
        expect(activity.maxSpeed) == 4.514
        expect(activity.averageHeartRate) == 138.8
        expect(activity.maxHeartRate) == 179.0
    }

    func test_encode_activity() throws {
        let jsonData = activityWithNoGpsJson.data(using: .utf8)!
        let activity = try JSONDecoder().decode(Activity.self, from: jsonData)
        let encoded = try JSONEncoder().encode(activity)
        let decoded = try JSONDecoder().decode(Activity.self, from: encoded)

        expect(decoded) == activity
    }

    func test_encode_activity_with_no_gps() throws {
        let jsonData = activityWithNoGpsJson.data(using: .utf8)!
        let activity = try JSONDecoder().decode(Activity.self, from: jsonData)
        let encoded = try JSONEncoder().encode(activity)
        let decoded = try JSONDecoder().decode(Activity.self, from: encoded)

        expect(decoded) == activity
    }
}

fileprivate extension ActivityTests {

    var activityWithGpsJson: String {
        return """
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
    }

    var activityWithNoGpsJson: String {
        return """
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
            "start_latlng": null,
            "end_latlng": null,
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
            "summary_polyline": null,
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
    }
}
