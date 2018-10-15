import XCTest
import Nimble
@testable import StravaKit

final class StravaOauthTests: XCTestCase {

    func test_authorize_readOnly() {
        let url = StravaOauth.authorize(
            clientId: "123", redirectUri: "test", alwaysShowAuthorizationPrompt: true)

        expect(url.absoluteString) ==
            "https://www.strava.com/oauth/authorize?response_type=code&client_id=123&redirect_uri=test&approval_prompt=force"
    }

    func test_authorize_viewPrivate() {
        let url = StravaOauth.authorize(
            clientId: "123", redirectUri: "test", viewPrivate: true, alwaysShowAuthorizationPrompt: true)

        expect(url.absoluteString) ==
        "https://www.strava.com/oauth/authorize?response_type=code&client_id=123&redirect_uri=test&approval_prompt=force&scope=view_private"
    }

    func test_authorize_write() {
        let url = StravaOauth.authorize(
            clientId: "123", redirectUri: "test", write: true, alwaysShowAuthorizationPrompt: true)

        expect(url.absoluteString) ==
        "https://www.strava.com/oauth/authorize?response_type=code&client_id=123&redirect_uri=test&approval_prompt=force&scope=write"
    }

    func test_authorize_viewPrivateAndWrite() {
        let url = StravaOauth.authorize(
            clientId: "123", redirectUri: "test", viewPrivate: true, write: true, alwaysShowAuthorizationPrompt: true)

        expect(url.absoluteString) ==
            "https://www.strava.com/oauth/authorize?response_type=code&client_id=123&redirect_uri=test&approval_prompt=force&scope=view_private,write"
    }
}
