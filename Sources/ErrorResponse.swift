public struct ErrorResponse: Codable, Equatable {

    public struct Error: Codable, Equatable {
        public let resource: String?
        public let field: String?
        public let code: String?

        public var description: String {
            return [resource, field, code]
                .compactMap { $0 }
                .joined(separator: " ")
        }
    }

    // Messages
    public static let badRequest = "Bad Request"
    public static let authorizationError = "Authorization Error"

    // Resources
    public static let refreshToken = "RefreshToken"

    // Fields
    public static let code = "code"
    public static let accessToken = "access_token"

    // Codes
    public static let invalid = "invalid"

    public let message: String?
    public let errors: [Error]

    public var description: String {
        return ([message] + errors.map { $0.description })
            .compactMap { $0 }
            .joined(separator: ",")
    }
}
