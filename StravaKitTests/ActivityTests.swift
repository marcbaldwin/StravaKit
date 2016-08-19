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
        return Activity(
            id: id,
            name: "08/23/2013 Oakland, CA",
            distance: 32486.1,
            movingTime: 5241,
            elapsedTime: 5427,
            totalElevationGain: 566.0,
            averageSpeed: 3.4,
            maxSpeed: 4.514,
            type: "Ride",
            startDate: "2013-08-24T00:04:12Z",
            localTimeZone: "America/Los_Angeles",
            polyline: "cetewLja@zYcG",
            isStaticTrainer: false,
            isCommute: false,
            isManual: false,
            averageHeartRate: 138.8,
            maxHeartRate: 179.0)
    }
}