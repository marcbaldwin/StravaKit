import Foundation
import Alamofire

func dataRequest(
    url: URL,
    method: HTTPMethod,
    parameters: Parameters,
    headers: HTTPHeaders? = nil
) async throws -> Data {
    try await withCheckedThrowingContinuation { continuation in
        Alamofire.Session.default
            .request(
                url,
                method: method,
                parameters: parameters,
                headers: headers
            )
            .responseData { response in
                do {
                    let data = try response.decode()
                    continuation.resume(returning: data)
                } catch let error {
                    continuation.resume(throwing: error)
                }
            }
    }
}

extension AFDataResponse<Data> {

    func decode() throws -> Data {
        guard let response else { throw StravaError.noResponse }


        switch(result) {
        case let .success(data):
            if response.statusCode >= 200 && response.statusCode <= 299 {
                return data
            }

            let error = try JSONDecoder().decode(ErrorResponse.self, from: data)

            if response.statusCode == 400 {
                if error.errors.contains(where: { error in error.resource == ErrorResponse.refreshToken }) {
                    throw StravaError.refreshTokenInvalid
                } else {
                    throw StravaError.badRequest(error)
                }
            }

            if response.statusCode == 401 {
                throw StravaError.accessTokenInvalid
            }

            if response.statusCode == 403 {
                throw StravaError.forbidden(error)
            }

            throw StravaError.apiUnexpectedError(error)

        case let .failure(error):
            throw error
        }
    }
}
