import XCTest
@testable import StravaKit

class BaseStravaClientTests: XCTestCase {

    var stravaClient: StravaClient!

    override func setUp() {
        super.setUp()
        stravaClient = StravaClient(clientId: "6780", clientSecret: "4b33f695b8779a9789f82a43e4796804829de2e6")
    }
}

extension BaseStravaClientTests {

    func failOnError() -> (NSError) -> Void {
        return { _ in
            XCTFail()
        }
    }
}