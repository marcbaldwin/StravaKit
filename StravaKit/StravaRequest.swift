import Alamofire
import SwiftyJSON

internal class Request {

    static func request<T>(_ method: HTTPMethod = .get, url: String, parameters: Parameters, transformer: @escaping (JSON) -> T, handler: @escaping (Response<T>) -> Void) {

        Alamofire.request(url, method: method, parameters: parameters.build())
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let response = response.response, response.statusCode == 401 {
                        handler(.failure(.unauthorized))
                    } else {
                        handler(.success(transformer(JSON(value))))
                    }
                case .failure(_): handler(.failure(.offline))
                }
            }
    }
}

internal class Parameters {
    fileprivate var parameters = [String : AnyObject]()

    func add(_ key: String, _ value: AnyObject) -> Self {
        parameters[key] = value
        return self
    }

    func build() -> [String : AnyObject] {
        return parameters
    }
}
