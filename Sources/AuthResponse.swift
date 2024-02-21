public protocol AuthDetailsResponse {

    var refreshToken: String { get }
    var accessToken: String { get }
    var accessTokenExpiry: Int64 { get }
}

public extension AuthDetailsResponse {

    var authDetails: AuthDetails {
        return AuthDetails(
            refreshToken: refreshToken,
            accessToken: accessToken,
            accessTokenExpiry: accessTokenExpiry
        )
    }
}

public struct AuthResponse: AuthDetailsResponse, Codable, Equatable {

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

public struct AuthRefreshTokenResponse: AuthDetailsResponse, Codable, Equatable {

    public let refreshToken: String
    public let accessToken: String
    public let accessTokenExpiry: Int64

    enum CodingKeys : String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case accessTokenExpiry = "expires_at"
    }
}
