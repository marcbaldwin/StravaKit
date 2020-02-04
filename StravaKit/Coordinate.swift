import CoreLocation

public struct Coordinate: Equatable, Hashable {

    public let latitude: CLLocationDegrees
    public let longitude: CLLocationDegrees
}

extension Coordinate: Codable {

    public init(from decoder: Decoder) throws {
        var unkyedContainer = try decoder.unkeyedContainer()
        let latitude = try unkyedContainer.decode(Double.self)
        let longitude = try unkyedContainer.decode(Double.self)
        self.init(latitude: latitude, longitude: longitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(latitude)
        try container.encode(longitude)
    }
}
