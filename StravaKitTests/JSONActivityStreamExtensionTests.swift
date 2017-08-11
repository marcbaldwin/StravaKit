import XCTest
import Nimble
import SwiftyJSON
import CoreLocation
@testable import StravaKit

class JSONActivityStreamExtensionTests: XCTestCase {

    var data: Data { return (try! Data(contentsOf: URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "ActivityStream", ofType: "json")!))) }

    func testShouldConvertJSONToActivityStream() {
        let stream = JSON(data: data).activityStream

        expect(stream.distance).to(equal([0, 1144.8]))
        expect(stream.time).to(equal([0, 189]))
        expect(stream.elevation).to(equal([12, 12.2]))
        expect(stream.speed).to(equal([0, 5.3]))
        expect(stream.coordinate).to(equal(
            [CLLocationCoordinate2D(latitude: 50.747493, longitude: -1.80385),
             CLLocationCoordinate2D(latitude: 50.741435, longitude: -1.807686)]
        ))
    }
}
