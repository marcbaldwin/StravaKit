
public struct Athlete: Codable {

    public let username: String?
    public let email: String?
    public let firstName: String
    public let lastName: String
    public let premium: Bool
    public let measurementPreference: MeasurementPreference

    enum CodingKeys : String, CodingKey {
        case username
        case email
        case firstName = "firstname"
        case lastName = "lastname"
        case premium
        case measurementPreference = "measurement_preference"
    }
}

public enum MeasurementPreference: String, Codable {
    case meters
    case feet
}
