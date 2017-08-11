import CoreLocation

public struct Activity {

    public let id: Int
    public let name: String
    public let distance: CLLocationDistance
    public let movingTime: CLLocationSpeed
    public let elapsedTime: TimeInterval
    public let totalElevationGain: CLLocationDistance
    public let averageSpeed: CLLocationSpeed
    public let maxSpeed: CLLocationSpeed
    public let type: String
    public let startDate: String
    public let localTimeZone: String
    public let polyline: String?
    public let isStaticTrainer: Bool
    public let isCommute: Bool
    public let isManual: Bool
    public let averageHeartRate: Float
    public let maxHeartRate: Float

    public init(
        id: Int,
        name: String,
        distance: CLLocationDistance,
        movingTime: TimeInterval,
        elapsedTime: TimeInterval,
        totalElevationGain: CLLocationDistance,
        averageSpeed: CLLocationSpeed,
        maxSpeed: CLLocationSpeed,
        type: String,
        startDate: String,
        localTimeZone: String,
        polyline: String?,
        isStaticTrainer: Bool,
        isCommute: Bool,
        isManual: Bool,
        averageHeartRate: Float,
        maxHeartRate: Float) {
        self.id = id
        self.name = name
        self.distance = distance
        self.movingTime = movingTime
        self.elapsedTime = elapsedTime
        self.totalElevationGain = totalElevationGain
        self.averageSpeed = averageSpeed
        self.maxSpeed = maxSpeed
        self.type = type
        self.startDate = startDate
        self.localTimeZone = localTimeZone
        self.polyline = polyline
        self.isStaticTrainer = isStaticTrainer
        self.isCommute = isCommute
        self.isManual = isManual
        self.averageHeartRate = averageHeartRate
        self.maxHeartRate = maxHeartRate
    }
}

extension Activity: Equatable {

    public static func ==(lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}
