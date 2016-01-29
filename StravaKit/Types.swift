import Foundation
import CoreLocation

typealias Distance = Float
typealias Speed = Float
typealias Time = NSTimeInterval
typealias Coordinate = CLLocationCoordinate2D
typealias Degrees = CLLocationDegrees

extension CLLocationCoordinate2D {

    init(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        self.init(latitude: latitude, longitude: longitude)
    }

    init(lat: CLLocationDegrees, lng: CLLocationDegrees) {
        self.init(latitude: lat, longitude: lng)
    }
}

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}