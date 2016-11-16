import XCTest
import Nimble
@testable import StravaKit

class StravaClientErrorTests: BaseStravaClientTests {

    override func setUp() {
        super.setUp()
        stravaClient = StravaClient(accessToken: "12345")
    }

    func test_givenAccessTokenIsInvalid_whenFetchActivitiesInDateRange_thenShouldReturnUnauthorizedError() {
        let dateFormatter = "yyyy:MM:d".dateFormatter()
        let weekBeginning = dateFormatter.date(from: "2015:05:25")!
        let weekEnd = dateFormatter.date(from: "2015:05:31")!

        stravaClient.athleteAcitvities(from: weekBeginning, to: weekEnd) { response in
            self.verifyResponseIsUnauthorized(response)
        }

        waitForExpectations()
    }

    func test_givenAccessTokenIsInvalid_whenFetchActivitiesByPage_thenShouldReturnUnauthorizedError() {
        stub("athlete/activities", withParams: "page=1&per_page=2", withJsonFromResource: "invalid_access_token")

        stravaClient.athleteAcitvities(page: 1, pageSize: 2) { response in
            self.verifyResponseIsUnauthorized(response)
        }

        waitForExpectations()
    }

    func test_givenAccessTokenIsInvalid_whenFetchActivityStream_thenShouldReturnUnauthorizedError() {
        stravaClient.activityStreamForActivityWithId(326040145, types: [StreamType.distance, .altitude]) { response in
            self.verifyResponseIsUnauthorized(response)
        }

        waitForExpectations()
    }
}

private extension StravaClientErrorTests {

    func verifyResponseIsUnauthorized<T>(_ response: Response<T>) {
        if case .failure(let error) = response {
            expect(error).to(equal(StravaError.unauthorized))
            expectation.fulfill()
        } else {
            fail()
        }
    }
}
