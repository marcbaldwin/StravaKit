import XCTest
import Nimble
@testable import StravaKit

class StravaClientTests: BaseStravaClientTests {

    func test_shouldReturnActivitiesBetweenDateRange() {
        let dateFormatter = "yyyy:MM:d".dateFormatter()
        let weekBeginning = dateFormatter.date(from: "2015:05:25")!
        let weekEnd = dateFormatter.date(from: "2015:05:31")!

        stravaClient.athleteAcitvities(from: weekBeginning, to: weekEnd) { response in
            if case .success(let activities) = response {
                expect(activities.count).to(equal(2))
                self.expectation.fulfill()
            }
        }

        waitForExpectations()
    }

    func test_shouldReturnActivityStreamForActivity() {
        stravaClient.activityStreamForActivityWithId(326040145, types: [StreamType.distance, .altitude]) { activityStream in
            expect(activityStream).toNot(beNil())
            self.expectation.fulfill()
        }
        waitForExpectations()
    }

    func test_shouldGetActivitiesByPage() {
        stub("athlete/activities", withParams: "page=1&per_page=2", withJsonFromResource: "activities_1_2")

        stravaClient.athleteAcitvities(page: 1, pageSize: 2) { response in
            if case .success(let activities) = response {
                expect(activities.count).to(equal(2))
                self.expectation.fulfill()
            }
        }
        
        waitForExpectations()
    }
}
