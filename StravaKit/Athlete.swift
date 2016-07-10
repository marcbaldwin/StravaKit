
public struct Athlete {
    public let username: String?
    public let email: String?
    public let firstName: String
    public let lastName: String
    public let premium: Bool
    public let measurementPreference: MeasurementPreference
}

public enum MeasurementPreference {
    case Meters
    case Feet
}