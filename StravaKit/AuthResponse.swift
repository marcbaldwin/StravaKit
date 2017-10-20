
public struct AuthResponse: Codable {

    public let accessToken: String

    enum CodingKeys : String, CodingKey {
        case accessToken = "access_token"
    }
}
