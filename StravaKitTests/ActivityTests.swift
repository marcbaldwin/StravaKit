import XCTest
import Nimble
@testable import StravaKit

class ActivityTests: XCTestCase {

    func test_activitiesWithSameIdShouldBeEqual() {
        expect(self.createActivityWithId(1) == self.createActivityWithId(1)).to(beTrue())
    }

    func test_activitiesWithDifferentIdsShouldNotBeEqual() {
        expect(self.createActivityWithId(1) == self.createActivityWithId(7)).to(beFalse())
    }
}

private extension ActivityTests {

    func createActivityWithId(id: Int) -> Activity {
        let builder = ActivityBuilder()
        builder.id = id
        builder.name = "08/23/2013 Oakland, CA"
        builder.distance = 32486.1
        builder.movingTime = 5241
        builder.elapsedTime = 5427
        builder.totalElevationGain = 566.0
        builder.type = "Ride"
        builder.startDate = NSDate(timeIntervalSince1970: 1377302652)
        builder.localTimeZone = NSTimeZone(name: "America/Los_Angeles")!
        builder.polyline = "cetewLja@zYcG"
        builder.startCoordinate = Coordinate(37.793551, -122.2686)
        builder.endCoordinate = Coordinate(37.792836, -122.268287)
        builder.achievementCount = 8
        builder.kudosCount = 0
        builder.commentCount = 0
        builder.athleteCount = 1
        builder.photoCount = 0
        builder.totalPhotoCount = 0
        builder.isStaticTrainer = false
        builder.isCommute = false
        builder.isManual = false
        builder.isPrivate = false
        builder.isFlagged = false
        builder.averageSpeed = 3.4
        builder.maxSpeed = 4.514
        builder.averageWatts = 163.6
        builder.weightedAverageWatts = 200
        builder.kilojoules = 857.6
        builder.deviceWatts = true
        builder.averageHeartRate = 138.8
        builder.maxHeartRate = 179.0
        return builder.build()
    }
}