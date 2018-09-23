import CoreLocation

public struct Activity: Codable {

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

extension Activity: Equatable {

    public static func ==(lhs: Activity, rhs: Activity) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.distance == rhs.distance &&
            lhs.movingTime == rhs.movingTime &&
            lhs.elapsedTime == rhs.elapsedTime &&
            lhs.totalElevationGain == rhs.totalElevationGain &&
            lhs.averageSpeed == rhs.averageSpeed &&
            lhs.maxSpeed == rhs.maxSpeed &&
            lhs.type == rhs.type &&
            lhs.startDate == rhs.startDate &&
            lhs.localTimeZone == rhs.localTimeZone &&
            lhs.map == rhs.map &&
            lhs.isStaticTrainer == rhs.isStaticTrainer &&
            lhs.isCommute == rhs.isCommute &&
            lhs.isManual == rhs.isManual &&
            lhs.averageHeartRate == rhs.averageHeartRate &&
            lhs.maxHeartRate == rhs.maxHeartRate
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
