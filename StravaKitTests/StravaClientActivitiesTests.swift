import XCTest
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
            XCTAssertEqual(2, activities.count)
            
            expectation.fulfill()
        }, failure: failOnError())

        waitForExpectationsWithTimeout(5) { error in

        }
    }

    func testShouldReturnActivityStreamForActivity() {

        let expectation = expectationWithDescription("")

        stravaClient.activityStreamForActivityWithId(326040145, types: [StreamType.Distance, .Altitude], success: { activityStream in
            XCTAssertNotNil(activityStream)
            expectation.fulfill()
        }, failure: failOnError())

        waitForExpectationsWithTimeout(5) { error in

        }
    }
}