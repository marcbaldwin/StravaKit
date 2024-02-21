import Foundation

extension HTTPDataResponse {

    func decode<T: Decodable>(type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: try decode())
    }

    func decode() throws -> Data {
        if statusCode >= 200 && statusCode <= 299 {
            return data
        }

        let error = try JSONDecoder().decode(ErrorResponse.self, from: data)

        if statusCode == 400 {
            if error.errors.contains(where: { error in error.resource == ErrorResponse.refreshToken }) {
                throw StravaError.refreshTokenInvalid
            } else {
                throw StravaError.badRequest(error)
            }
        }

        if statusCode == 401 {
            throw StravaError.accessTokenInvalid
        }

        if statusCode == 403 {
            throw StravaError.forbidden(error)
        }

        throw StravaError.apiUnexpectedError(error)
    }
}
