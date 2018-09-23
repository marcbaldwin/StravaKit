
public struct AuthResponse: Codable, Equatable {

    public let accessToken: String
    public let athlete: Athlete

    enum CodingKeys : String, CodingKey {
        case accessToken = "access_token"
        case athlete
    }
}
