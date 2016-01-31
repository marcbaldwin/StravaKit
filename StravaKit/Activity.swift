public class Activity {

    var id: Int!
    var name: String!
    var distance: Distance!
    var movingTime: Time!
    var elapsedTime: Time!
    var totalElevationGain: Distance!

    var averageSpeed: Speed!
    var maxSpeed: Speed!

    var type: String!
    var startDate: NSDate!
    var localTimeZone: NSTimeZone!

    var startCoordinate: Coordinate!
    var endCoordinate: Coordinate!

    var achievementCount: Int!
    var kudosCount: Int!
    var commentCount: Int!
    var athleteCount: Int!
    var photoCount: Int!
    var totalPhotoCount: Int!
    var isStaticTrainer: Bool!
    var isCommute: Bool!
    var isManual: Bool!
    var isPrivate: Bool!
    var isFlagged: Bool!
    var averageWatts: Float!
    var weightedAverageWatts: Float!
    var kilojoules: Float!
    var deviceWatts: Bool!
    var averageHeartRate: Float!
    var maxHeartRate: Float!
}