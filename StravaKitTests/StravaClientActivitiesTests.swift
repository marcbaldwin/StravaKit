import XCTest
import Nimble
@testable import StravaKit

class StravaClientActivitiesTests: BaseStravaClientTests {

    override func setUp() {
        super.setUp()
        stravaClient.accessToken = "464f7efa6615307e97ecf404cdbaeaff547f7d98"
    }

    func testShouldReturnActivitiesBetweenDateRange() {
        let expectation = expectationWithDescription("")

        let dateFormatter = "yyyy:MM:d".dateFormatter()
        let weekBeginning = dateFormatter.dateFromString("2015:05:25")!
        let weekEnd = dateFormatter.dateFromString("2015:05:31")!

        stravaClient.activitiesForLocalAthlete(weekBeginning, to: weekEnd, success: { activities in
            expect(activities.count).to(equal(2))
            expectation.fulfill()
        }, failure: failOnError())

        waitForExpectations()
    }

    func testShouldReturnActivityStreamForActivity() {
        let expectation = expectationWithDescription("")

        stravaClient.activityStreamForActivityWithId(326040145, types: [StreamType.Distance, .Altitude], success: { activityStream in
            expect(activityStream).toNot(beNil())
            expectation.fulfill()
        }, failure: failOnError())

        waitForExpectations()
    }
}