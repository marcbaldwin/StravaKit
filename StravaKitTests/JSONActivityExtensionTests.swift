import XCTest
import Nimble
import SwiftyJSON
@testable import StravaKit

class JSONActivityEtensionTests: XCTestCase {

    var data: NSData { return NSData(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("Activity", ofType: "json")!)! }

    func testShouldConvertJSONToActivity() {

        let activity = JSON(data: data).activity

        expect(activity.id).to(equal(8529483))
        expect(activity.name).to(equal("08/23/2013 Oakland, CA"))
        expect(activity.distance).to(equal(32486.1))
        expect(activity.movingTime).to(equal(5241))
        expect(activity.elapsedTime).to(equal(5427))
        expect(activity.totalElevationGain).to(equal(566.0))
        expect(activity.type).to(equal("Ride"))
        expect(activity.startDate).to(equal(NSDate(timeIntervalSince1970: 1377302652)))
        expect(activity.localTimeZone).to(equal(NSTimeZone(name: "America/Los_Angeles")!))
        expect(activity.polyline).to(equal("cetewLja@zYcG"))
        expect(activity.startCoordinate).to(equal(Coordinate(37.793551, -122.2686)))
        expect(activity.endCoordinate).to(equal(Coordinate(37.792836, -122.268287)))
        expect(activity.achievementCount).to(equal(8))
        expect(activity.kudosCount).to(equal(0))
        expect(activity.commentCount).to(equal(0))
        expect(activity.athleteCount).to(equal(1))
        expect(activity.photoCount).to(equal(0))
        expect(activity.totalPhotoCount).to(equal(0))
        expect(activity.isStaticTrainer).to(equal(false))
        expect(activity.isCommute).to(equal(false))
        expect(activity.isManual).to(equal(false))
        expect(activity.isPrivate).to(equal(false))
        expect(activity.isFlagged).to(equal(false))
        expect(activity.averageSpeed).to(equal(3.4))
        expect(activity.maxSpeed).to(equal(4.514))
        expect(activity.averageWatts).to(equal(163.6))
        expect(activity.weightedAverageWatts).to(equal(200))
        expect(activity.kilojoules).to(equal(857.6))
        expect(activity.deviceWatts).to(equal(true))
        expect(activity.averageHeartRate).to(equal(138.8))
        expect(activity.maxHeartRate).to(equal(179.0))
    }
}