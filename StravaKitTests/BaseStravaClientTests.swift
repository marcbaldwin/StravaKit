import XCTest
import Mockingjay
@testable import StravaKit

class BaseStravaClientTests: XCTestCase {

    var stravaClient: StravaClient!

    override func setUp() {
        super.setUp()
        stravaClient = StravaClient(accessToken: "6abae0f7b8fee09c4f46ba0a7207d4f57637dabd")
    }
}

extension XCTestCase {

    func createExpectation() -> XCTestExpectation {
        return expectationWithDescription("")
    }

    func waitForExpectations() {
        waitForExpectationsWithTimeout(1) { _ in }
    }

    func failOnError() -> (NSError) -> Void {
        return { _ in XCTFail() }
    }

    func stub(uri: String, withParams params: String, withJsonFromResource: String) {
        let path = NSBundle(forClass: self.dynamicType).pathForResource(withJsonFromResource, ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        stub(http(.GET, uri: "https://www.strava.com/api/v3/" + "?access_token=464f7efa6615307e97ecf404cdbaeaff547f7d98&" + params), builder: jsonData(data))
    }
}