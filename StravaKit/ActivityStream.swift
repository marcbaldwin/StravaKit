import CoreLocation

public enum StreamType: String {
    case latLng = "latlng"
    case distance = "distance"
    case altitude = "altitude"
    case speed = "velocity_smooth"
    case time = "time"
}

public struct ActivityStream {

    let distance: [CLLocationDistance]?
    let coordinate: [CLLocationCoordinate2D]?
    let elevation: [CLLocationDistance]?
    let speed: [CLLocationSpeed]?
    let time: [TimeInterval]?

    public init(distance: [CLLocationDistance]?,
         coordinate: [CLLocationCoordinate2D]?,
         elevation: [CLLocationDistance]?,
         speed: [CLLocationSpeed]?,
         time: [TimeInterval]?) {
        self.distance = distance
        self.coordinate = coordinate
        self.elevation = elevation
        self.speed = speed
        self.time = time
    }
}
