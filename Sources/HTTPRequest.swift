//import Alamofire
//import Foundation
//
//struct HTTPDataResponse {
//
//    var statusCode: Int { response.statusCode }
//
//    let response: HTTPURLResponse
//    let data: Data
//}
//
//extension DataRequest: ReactiveCompatible { }
//
//extension Reactive where Base: DataRequest {
//
//    func responseData() -> Single<HTTPDataResponse> {
//        .create { subscriber in
//
//            self.base.responseData { packedResponse in
//                switch packedResponse.result {
//
//                case let .success(data):
//                    subscriber(.success(HTTPDataResponse(response: packedResponse.response!, data: data)))
//
//                case let .failure(error):
//                    subscriber(.failure(error as Error))
//                }
//            }
//
//            return Disposables.create {
//                self.base.cancel()
//            }
//        }
//    }
//}
