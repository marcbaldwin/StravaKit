public struct AuthResponse: Codable, Equatable {

    public let refreshToken: String
    public let accessToken: String
    public let accessTokenExpiry: Int64
    public let athlete: Athlete

    enum CodingKeys : String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case accessTokenExpiry = "expires_at"
        case athlete
    }
}

public struct AuthRefreshTokenResponse: Codable, Equatable {

    public let refreshToken: String
    public let accessToken: String
    public let accessTokenExpiry: Int64

    var authDetails: AuthDetails {
        return AuthDetails(
            refreshToken: refreshToken,
            accessToken: accessToken,
            accessTokenExpiry: accessTokenExpiry
        )
    }

    enum CodingKeys : String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case accessTokenExpiry = "expires_at"
    }
}
