import Foundation

public enum StravaError: LocalizedError, Equatable {

    // Unexpected error from authenticate
    case authUnexpectedError(String?)

    // User denied access to the app from the authenticate screen
    case authUserDeniedAccess

    // 400 Bad request
    case badRequest(ErrorResponse)

    // 400 Bad request -> Refresh token invalid
    case refreshTokenInvalid

    // 401 Unauthorized -> Access token invalid
    case accessTokenInvalid

    // 403 Forbidden (Likely user has not accepted license agreement)
    case forbidden(ErrorResponse)

    // 4XX Other
    case apiUnexpectedError(ErrorResponse)

    public var errorDescription: String? {
        switch self {
        case let .authUnexpectedError(code):
            return "Unexpected error, code: '\(code ?? "None")'"

        case .authUserDeniedAccess:
            return "User denied access"

        case let .badRequest(response):
            return "Bad request, response: '\(response.description)'"

        case .refreshTokenInvalid:
            return "Refresh token invalid"

        case .accessTokenInvalid:
            return "Access token invalid"

        case let .forbidden(response):
            return "Forbidden, response: '\(response.description)'"

        case let .apiUnexpectedError(response):
            return "Unexpected error, response: '\(response.description)'"
        }
    }
}
