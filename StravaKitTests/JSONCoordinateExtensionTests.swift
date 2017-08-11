import XCTest
import CoreLocation
import Nimble
import SwiftyJSON
@testable import StravaKit

class JSONCoordinateExtensionTests: XCTestCase {

    func testShouldConvertJSONToCoordinate() {
        let coordinate = JSON.parse("[50.747492, -1.803626]").coordinate
        expect(coordinate).to(equal(CLLocationCoordinate2D(latitude: 50.747492, longitude: -1.803626)))
    }

    func testShouldConvertJSONToCoordinates() {
        let coordinates = JSON.parse("[[50.747493, -1.80385], [50.741435, -1.807686]]").coordinates
        expect(coordinates).to(equal([
            CLLocationCoordinate2D(latitude: 50.747493, longitude: -1.80385),
            CLLocationCoordinate2D(latitude: 50.741435, longitude: -1.807686)
            ])
        )
    }
}
