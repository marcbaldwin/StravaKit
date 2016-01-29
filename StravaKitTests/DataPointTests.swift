import XCTest

class DataPointTests: XCTestCase {

    let dataPoint = TestData().dataPoint0

    func testShouldCalculateAverageSpeed() {
        XCTAssertEqualWithAccuracy(1/3, dataPoint.averageSpeed, 0.001)
    }
}