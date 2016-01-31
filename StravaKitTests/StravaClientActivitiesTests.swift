import XCTest
import Nimble
@testable import StravaKit

class StravaClientActivitiesTests: BaseStravaClientTests {

    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        expectation = createExpectation()
    }

    func testShouldReturnActivitiesBetweenDateRange() {
        let dateFormatter = "yyyy:MM:d".dateFormatter()
        let weekBeginning = dateFormatter.dateFromString("2015:05:25")!
        let weekEnd = dateFormatter.dateFromString("2015:05:31")!

        stravaClient.athleteAcitvities(from: weekBeginning, to: weekEnd).onSuccess { activities in
            expect(activities.count).to(equal(2))
            self.expectation.fulfill()
        }

        waitForExpectations()
    }

    func testShouldReturnActivityStreamForActivity() {
        stravaClient.activityStreamForActivityWithId(326040145, types: [StreamType.Distance, .Altitude]).onSuccess { activityStream in
            expect(activityStream).toNot(beNil())
            self.expectation.fulfill()
        }
        waitForExpectations()
    }

    func testShouldGetActivitiesByPage() {
        stub("athlete/activities", withParams: "page=1&per_page=2", withJsonFromResource: "activities_1_2")

        stravaClient.athleteAcitvities(page: 1, pageSize: 2).onSuccess { activities in
            expect(activities.count).to(equal(2))
            self.expectation.fulfill()
        }
        
        waitForExpectations()
    }
}