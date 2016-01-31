import XCTest
import Nimble
@testable import StravaKit

class StravaClientAuthorizationTests: XCTestCase {

    var stravaAuthorizer: StravaAuthorizer!

    override func setUp() {
        super.setUp()
        stravaAuthorizer = StravaAuthorizer(clientId: "6780", clientSecret: "4b33f695b8779a9789f82a43e4796804829de2e6")
    }

    func testWhenTokenExchangeCompletesSuccessfully_thenDelegateIsNotified() {
        let expectation = createExpectation()

        stravaAuthorizer.exchangeTokenWithAuthorizationCode("329fd1e3fa6f3dda977a983f5e206936abefce76") { accessToken in
            expect(accessToken).to(equal("464f7efa6615307e97ecf404cdbaeaff547f7d98"))
            expectation.fulfill()
        }

        waitForExpectations()
    }
}