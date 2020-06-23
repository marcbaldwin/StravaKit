import XCTest
import Nimble
@testable import StravaKit

final class StravaAuthApiTests: XCTestCase {

    func test_authorizeUrlWithSingleScope() {
        let client = StravaAuthApiClient(clientId: "123", clientSecret: "abcd")
        let url = client.authorizeUrl(redirectUri: "test", scopes: .read)

        expect(url.absoluteString) ==
        "https://www.strava.com/oauth/mobile/authorize?response_type=code&client_id=123&redirect_uri=test&approval_prompt=auto&scope=read"
    }

    func test_authorizeUrlWithMultipleScopes() {
        let client = StravaAuthApiClient(clientId: "123", clientSecret: "abcd")
        let url = client.authorizeUrl(redirectUri: "test", scopes: .read, .activityWrite)

        expect(url.absoluteString) ==
        "https://www.strava.com/oauth/mobile/authorize?response_type=code&client_id=123&redirect_uri=test&approval_prompt=auto&scope=read,activity:write"
    }
}
