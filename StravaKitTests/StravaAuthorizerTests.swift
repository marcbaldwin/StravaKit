import XCTest
import Nimble
@testable import StravaKit

class StravaAuthorizerTests: XCTestCase {

    var stravaAuthorizer: StravaAuthorizer!

    override func setUp() {
        super.setUp()
        stravaAuthorizer = StravaAuthorizer(clientId: "6780", clientSecret: "4b33f695b8779a9789f82a43e4796804829de2e6")
    }

    func test_shouldNotifyDelegateWhenTokenExchangeCompletes() {
        let expectation = createExpectation()

        class DelegateSpy: StravaAuthorizerDelegate {
            var expectation: XCTestExpectation
            var accessToken: String?

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func didAuthorizeAthlete(athlete: Athlete?, withAccessToken accessToken: String) {
                self.accessToken = accessToken
                expectation.fulfill()
            }
        }

        let spy = DelegateSpy(expectation: expectation)

        stravaAuthorizer.delegate = spy

        stravaAuthorizer.exchangeTokenWithAuthorizationCode("329fd1e3fa6f3dda977a983f5e206936abefce76")

        waitForExpectations()

        expect(spy.accessToken).to(equal("6abae0f7b8fee09c4f46ba0a7207d4f57637dabd"))
    }
}