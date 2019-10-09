import XCTest
import Nimble
@testable import StravaKit

final class StravaAuthApiTests: XCTestCase {

    func test_authorize_readOnly() {

        let client = StravaAuthApiClient(clientId: "123", clientSecret: "abcd")
        let url = client.authorizeUrl(redirectUri: "test", scope: "activity:write")

        expect(url.absoluteString) ==
        "https://www.strava.com/oauth/mobile/authorize?response_type=code&client_id=123&redirect_uri=test&approval_prompt=auto&scope=activity:write"
    }
}
