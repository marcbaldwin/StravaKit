import XCTest
import Mockingjay
@testable import StravaKit

class BaseStravaClientTests: XCTestCase {

    var stravaClient: StravaClient!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        stravaClient = StravaClient(accessToken: "4435db5b6cd26c8ab99b8983acaa47d38382f5c9")
        expectation = createExpectation()
    }
}

extension XCTestCase {

    func createExpectation() -> XCTestExpectation {
        return expectation(description: "")
    }

    func waitForExpectations() {
        self.waitForExpectations(timeout: 1) { _ in }
    }

    func failOnError() -> (NSError) -> Void {
        return { _ in XCTFail() }
    }

    func stub(_ uri: String, withParams params: String, withJsonFromResource: String) {
        let path = Bundle(for: type(of: self)).path(forResource: withJsonFromResource, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        stub(http(.get, uri: "https://www.strava.com/api/v3/" + "?access_token=464f7efa6615307e97ecf404cdbaeaff547f7d98&" + params), jsonData(data))
    }
}
