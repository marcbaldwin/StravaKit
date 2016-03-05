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
        let weekBeginning = dateFormatter.dateFromString("2015:05:25")!
        let weekEnd = dateFormatter.dateFromString("2015:05:31")!

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
        stravaClient.activityStreamForActivityWithId(326040145, types: [StreamType.Distance, .Altitude]) { response in
            self.verifyResponseIsUnauthorized(response)
        }

        waitForExpectations()
    }
}

private extension StravaClientErrorTests {

    func verifyResponseIsUnauthorized<T>(response: Response<T>) {
        if case .Failure(let error) = response {
            expect(error).to(equal(StravaError.Unauthorized))
            expectation.fulfill()
        } else {
            fail()
        }
    }
}