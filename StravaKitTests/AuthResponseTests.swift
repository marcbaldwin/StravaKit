import XCTest
import Nimble
@testable import StravaKit

class AuthResponseTests: XCTestCase {

    func test_decode_auth_response() throws {
        let jsonString = """
            {
                "access_token": "83ebeabdec09f6670863766f792ead24d61fe3f9",
                "refresh_token": "abcd",
                "expires_at": 12345,
                "athlete": {
                    "id": 227615,
                    "resource_state": 2,
                    "firstname": "John",
                    "lastname": "Applestrava",
                    "profile_medium": "http://pics.com/227615/medium.jpg",
                    "profile": "http://pics.com/227615/large.jpg",
                    "city": "San Francisco",
                    "state": "California",
                    "country": "United States",
                    "sex": "M",
                    "premium": true,
                    "email": "john@applestrava.com",
                    "created_at": "2008-01-01T17:44:00Z",
                    "updated_at": "2013-09-04T20:00:50Z"
                }
            }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: jsonData)

        expect(authResponse.refreshToken) == "abcd"
        expect(authResponse.accessToken) == "83ebeabdec09f6670863766f792ead24d61fe3f9"
        expect(authResponse.accessTokenExpiry) == 12345
        expect(authResponse.athlete.id) == 227615
        expect(authResponse.athlete.email) == "john@applestrava.com"
        expect(authResponse.athlete.firstName) == "John"
        expect(authResponse.athlete.lastName) == "Applestrava"
        expect(authResponse.athlete.country) == "United States"
        expect(authResponse.athlete.hasPremium) == true
    }

    func test_decode_auth_response_without_country() throws {
        let jsonString = """
            {
                "access_token": "83ebeabdec09f6670863766f792ead24d61fe3f9",
                "refresh_token": "abcd",
                "expires_at": 12345,
                "athlete": {
                    "id": 227615,
                    "resource_state": 2,
                    "firstname": "John",
                    "lastname": "Applestrava",
                    "profile_medium": "http://pics.com/227615/medium.jpg",
                    "profile": "http://pics.com/227615/large.jpg",
                    "sex": "M",
                    "premium": false,
                    "email": "john@applestrava.com",
                    "created_at": "2008-01-01T17:44:00Z",
                    "updated_at": "2013-09-04T20:00:50Z"
                }
            }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: jsonData)

        expect(authResponse.refreshToken) == "abcd"
        expect(authResponse.accessToken) == "83ebeabdec09f6670863766f792ead24d61fe3f9"
        expect(authResponse.accessTokenExpiry) == 12345
        expect(authResponse.athlete.id) == 227615
        expect(authResponse.athlete.email) == "john@applestrava.com"
        expect(authResponse.athlete.firstName) == "John"
        expect(authResponse.athlete.lastName) == "Applestrava"
        expect(authResponse.athlete.country).to(beNil())
        expect(authResponse.athlete.hasPremium) == false
    }
}
