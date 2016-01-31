import CoreLocation

public typealias Distance = Float
public typealias Speed = Float
public typealias Duration = Int
public typealias Time = Int
public typealias Coordinate = CLLocationCoordinate2D
public typealias Degrees = CLLocationDegrees

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