import CoreLocation

public struct Activity: Codable, Equatable {

    public let id: Int
    public let name: String
    public let distance: CLLocationDistance
    public let movingTime: TimeInterval
    public let elapsedTime: TimeInterval
    public let totalElevationGain: CLLocationDistance
    public let averageSpeed: CLLocationSpeed
    public let maxSpeed: CLLocationSpeed
    public let type: String
    public let startDate: String
    public let localTimeZone: String
    public let start: CLLocationCoordinate2D?
    public let end: CLLocationCoordinate2D?
    public let map: Map
    public let isStaticTrainer: Bool
    public let isCommute: Bool
    public let isManual: Bool
    public let averageHeartRate: Float?
    public let maxHeartRate: Float?

    enum CodingKeys : String, CodingKey {
        case id
        case name
        case distance
        case movingTime = "moving_time"
        case elapsedTime = "elapsed_time"
        case totalElevationGain = "total_elevation_gain"
        case averageSpeed = "average_speed"
        case maxSpeed = "max_speed"
        case type
        case startDate = "start_date"
        case localTimeZone = "timezone"
        case start = "start_latlng"
        case end = "end_latlng"
        case map
        case isStaticTrainer = "trainer"
        case isCommute = "commute"
        case isManual = "manual"
        case averageHeartRate = "average_heartrate"
        case maxHeartRate = "max_heartrate"
    }
}

extension CLLocationCoordinate2D: Codable {

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

extension CLLocationCoordinate2D: Equatable {

    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
