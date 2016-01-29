import XCTest
@testable import StravaKit

class DataPointTests: XCTestCase {

    let dataPoint = DataPointBuilder().distance(10).time(30).elevation(12).speed(2.2).build()

    func testShouldCalculateAverageSpeed() {
        XCTAssertEqualWithAccuracy(1/3, dataPoint.averageSpeed, accuracy: 0.001)
    }
}