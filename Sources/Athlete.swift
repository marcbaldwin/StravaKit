public struct Athlete: Codable, Equatable, Hashable, Identifiable {

    public let id: Int64
    public let firstName: String
    public let lastName: String
    public let country: String?
    public let hasPremium: Bool

    // Detailed representation only
    public let measurementPreference: MeasurementPreference?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "firstname"
        case lastName = "lastname"
        case country
        case hasPremium = "premium"
        case measurementPreference = "measurement_preference"
    }
}

public enum MeasurementPreference: String, Codable, Equatable, Hashable {
    case meters
    case feet
}
