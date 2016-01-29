import XCTest
import Nimble
import SwiftyJSON
@testable import StravaKit

class JSONCoordinateExtensionTests: XCTestCase {

    let json = "[50.747492, -1.803626]"

    var data: NSData { return (self.json as NSString).dataUsingEncoding(NSUTF8StringEncoding)! }

    func testShouldConvertJSONToCoordinate() {
        let coordinate = JSON(data: data).coordinate
        expect(coordinate).to(equal(Coordinate(50.747492, -1.803626)))
    }
}