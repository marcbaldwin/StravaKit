import Foundation
import SwiftyJSON

extension JSON {

    var coordinate: Coordinate {
        let latitudeLongitude = arrayObject!
        return Coordinate(latitudeLongitude[0].doubleValue!, latitudeLongitude[1].doubleValue!)
    }
}