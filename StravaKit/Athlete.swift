
public struct Athlete {
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let premium: Bool
    let measurementPreference: MeasurementPreference
}

public enum MeasurementPreference {
    case Meters
    case Feet
}