import Foundation
import SwiftyJSON
import XCTest

class JSONActivityStreamExtensionTests: XCTestCase {

    var data: NSData { return NSData(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("ActivityStream", ofType: "json")!)! }

    func testShouldConvertJSONToActivityStream() {

        let stream = JSON(data: data).activityStream

        XCTAssertEqual(2, stream.dataPoints.count)

        let dataPointA = stream.dataPoints[0]
        XCTAssertEqual(Distance(0), dataPointA.distance!)
        XCTAssertEqual(Coordinate(50.747493, -1.80385), dataPointA.coordinate!)
        XCTAssertEqual(Distance(12), dataPointA.elevation!)
        XCTAssertEqual(Speed(0), dataPointA.speed!)
        XCTAssertEqual(Time(0), dataPointA.time!)

        let dataPointB = stream.dataPoints[1]
        XCTAssertEqual(Distance(1144.8), dataPointB.distance!)
        XCTAssertEqual(Coordinate(50.741435, -1.807686), dataPointB.coordinate!)
        XCTAssertEqual(Distance(12.2), dataPointB.elevation!)
        XCTAssertEqual(Speed(5.3), dataPointB.speed!)
        XCTAssertEqual(Time(189), dataPointB.time!)
    }
}