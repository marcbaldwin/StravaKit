import CoreLocation

public struct Activity: Codable, Equatable, Hashable, Identifiable {

    public let id: Int64
    public let name: String
    public let distance: CLLocationDistance
    public let movingTime: TimeInterval
    public let elapsedTime: TimeInterval
    public let totalElevationGain: CLLocationDistance
    public let averageSpeed: CLLocationSpeed
    public let maxSpeed: CLLocationSpeed
    public let type: String
    public let startDate: String
    public let localStartDate: String
    public let localTimeZone: String
    public let utcOffset: Int64
    public let map: Map?
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
        case localStartDate = "start_date_local"
        case localTimeZone = "timezone"
        case utcOffset = "utc_offset"
        case map
        case isStaticTrainer = "trainer"
        case isCommute = "commute"
        case isManual = "manual"
        case averageHeartRate = "average_heartrate"
        case maxHeartRate = "max_heartrate"
    }
}
