import Foundation

public struct AuthDetails: Codable, Equatable, Hashable {

    public let refreshToken: String
    public let accessToken: String
    public let accessTokenExpiry: Int64

    public var hasExpired: Bool {
        return Date().timeIntervalSince1970 >= Double(accessTokenExpiry)
    }

    public init(
        refreshToken: String,
        accessToken: String,
        accessTokenExpiry: Int64
    ) {
        self.refreshToken = refreshToken
        self.accessToken = accessToken
        self.accessTokenExpiry = accessTokenExpiry
    }
}
