import Foundation
import SwiftyJSON
import XCTest

class JSONActivityEtensionTests: XCTestCase {

    var data: NSData { return NSData(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("Activity", ofType: "json")!)! }

    func testShouldConvertJSONToActivity() {

        let activity = JSON(data: data).activity

        XCTAssertEqual(8529483, activity.id)
        XCTAssertEqual("08/23/2013 Oakland, CA", activity.name)
        XCTAssertEqual(32486.1, activity.distance)
        XCTAssertEqual(5241, activity.movingTime)
        XCTAssertEqual(5427, activity.elapsedTime)
        XCTAssertEqual(566.0, activity.totalElevationGain)
        XCTAssertEqual("Ride", activity.type)
        XCTAssertEqual(NSDate(timeIntervalSince1970: 1377302652), activity.startDate)
        XCTAssertEqual(NSTimeZone(name: "America/Los_Angeles")!, activity.localTimeZone)
        XCTAssertEqual(Coordinate(37.793551, -122.2686), activity.startCoordinate)
        XCTAssertEqual(Coordinate(37.792836, -122.268287), activity.endCoordinate)
        XCTAssertEqual("Oakland", activity.locationCity)
        XCTAssertEqual("CA", activity.locationState!)
        XCTAssertEqual("United States", activity.locationCountry)
        XCTAssertEqual(8, activity.achievementCount)
        XCTAssertEqual(0, activity.kudosCount)
        XCTAssertEqual(0, activity.commentCount)
        XCTAssertEqual(1, activity.athleteCount)
        XCTAssertEqual(0, activity.photoCount)
        XCTAssertEqual(0, activity.totalPhotoCount)
        XCTAssertEqual(false, activity.isStaticTrainer)
        XCTAssertEqual(false, activity.isCommute)
        XCTAssertEqual(false, activity.isManual)
        XCTAssertEqual(false, activity.isPrivate)
        XCTAssertEqual(false, activity.isFlagged)
        XCTAssertEqual(3.4, activity.averageSpeed)
        XCTAssertEqual(4.514, activity.maxSpeed)
        XCTAssertEqual(163.6, activity.averageWatts)
        XCTAssertEqual(200, activity.weightedAverageWatts)
        XCTAssertEqual(857.6, activity.kilojoules)
        XCTAssertEqual(true, activity.deviceWatts)
        XCTAssertEqual(138.8, activity.averageHeartRate)
        XCTAssertEqual(179.0, activity.maxHeartRate)
    }
}