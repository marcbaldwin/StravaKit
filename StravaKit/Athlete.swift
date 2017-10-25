
public struct Athlete: Codable {

    public let id: Int
    public let email: String?
    public let firstName: String
    public let lastName: String
    public let country: String
    public let hasPremium: Bool
    public let measurementPreference: MeasurementPreference?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "firstname"
        case lastName = "lastname"
        case country
        case hasPremium = "premium"
        case measurementPreference = "measurement_preference"
    }
}

public enum MeasurementPreference: String, Codable {
    case meters
    case feet
}
