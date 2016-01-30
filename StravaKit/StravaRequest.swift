import Alamofire

class Request<T> {

    private let url: String
    private let parameters: Parameters
    private let transformer: (AnyObject) -> T

    init(url: String, parameters: Parameters, transformer: (AnyObject) -> T) {
        self.url = url
        self.parameters = parameters
        self.transformer = transformer
    }

    func onSuccess(handler: (T) -> ()) {
        Alamofire.request(.GET, url, parameters: parameters.build()).responseJSON { response in
            if let error = response.result.error {
                print(error)
            }
            else {
                handler(self.transformer(response.result.value!))
            }
        }
    }
}

internal class Parameters {
    private var parameters = [String : AnyObject]()

    func add(key: String, _ value: AnyObject) -> Self {
        parameters[key] = value
        return self
    }

    func build() -> [String : AnyObject] {
        return parameters
    }
}