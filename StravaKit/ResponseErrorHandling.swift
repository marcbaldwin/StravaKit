import Moya

extension Response {

    func decode<T: Decodable>(type: T.Type) throws -> T {
        if statusCode >= 200 && statusCode <= 299 {
            return try JSONDecoder().decode(type, from: data)
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
