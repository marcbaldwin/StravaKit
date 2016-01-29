import XCTest
@testable import StravaKit

class StravaClientAuthorizationTests: BaseStravaClientTests {

    func testShouldAuthorizeClient() {

        let callbackURL = NSURL(string: "stravaclient://mibaldwin.uk?state=RequestAccessState&code=329fd1e3fa6f3dda977a983f5e206936abefce76")!

        let expectation = expectationWithDescription("Should authorize successfully")

        stravaClient.handleRequestAccessCallbackWithURL(callbackURL, success: { athlete in

            XCTAssertNotNil(athlete)

            expectation.fulfill()
        }, failure: failOnError())

        waitForExpectationsWithTimeout(5) { error in

        }
    }
}