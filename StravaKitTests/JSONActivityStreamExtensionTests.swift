import XCTest
import Nimble
import SwiftyJSON
@testable import StravaKit

class JSONActivityStreamExtensionTests: XCTestCase {

    var data: Data { return (try! Data(contentsOf: URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "ActivityStream", ofType: "json")!))) }

    func testShouldConvertJSONToActivityStream() {
        let stream = JSON(data: data).activityStream

        expect(stream.count).to(equal(2))

        let dataPointA = stream[0]
        expect(dataPointA.distance).to(equal(Distance(0)))
        expect(dataPointA.coordinate).to(equal(Coordinate(50.747493, -1.80385)))
        expect(dataPointA.elevation).to(equal(Distance(12)))
        expect(dataPointA.speed).to(equal(Speed(0)))
        expect(dataPointA.time).to(equal(Time(0)))

        let dataPointB = stream[1]
        expect(dataPointB.distance).to(equal(Distance(1144.8)))
        expect(dataPointB.coordinate).to(equal(Coordinate(50.741435, -1.807686)))
        expect(dataPointB.elevation).to(equal(Distance(12.2)))
        expect(dataPointB.speed).to(equal(Speed(5.3)))
        expect(dataPointB.time).to(equal(Time(189)))
    }
}
