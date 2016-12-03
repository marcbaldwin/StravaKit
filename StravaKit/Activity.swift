public struct Activity {

    public let id: Int
    public let name: String
    public let distance: Distance
    public let movingTime: Duration
    public let elapsedTime: Duration
    public let totalElevationGain: Distance
    public let averageSpeed: Speed
    public let maxSpeed: Speed
    public let type: String
    public let startDate: String
    public let localTimeZone: String
    public let polyline: String
    public let isStaticTrainer: Bool
    public let isCommute: Bool
    public let isManual: Bool
    public let averageHeartRate: Float
    public let maxHeartRate: Float

    public init(
        id: Int,
        name: String,
        distance: Distance,
        movingTime: Duration,
        elapsedTime: Duration,
        totalElevationGain: Distance,
        averageSpeed: Speed,
        maxSpeed: Speed,
        type: String,
        startDate: String,
        localTimeZone: String,
        polyline: String,
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

extension Activity: Equatable { }

public func ==(lhs: Activity, rhs: Activity) -> Bool {
    return lhs.id == rhs.id
}
