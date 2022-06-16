import Alamofire
import Combine
import Foundation

struct WebRequest {
    static func request<T: Decodable, E: Error>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        decoder: JSONDecoder = JSONDecoder(),
        headers: HTTPHeaders? = nil,
        sessionManager: Alamofire.Session
    ) -> Future<T, E> {
        Future({ promise in
            sessionManager
                .request(
                    url,
                    method: method,
                    parameters: parameters,
                    headers: headers
                )
                .responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
                    switch response.result {
                        
                    case .success(let value):
                        promise(.success(value))
                        
                    case .failure(let error):
                        promise(.failure(
                            NSError(domain: error.destinationURL?.absoluteString ?? "", code: error.responseCode ?? 0) as! E
                        ))
                    }
                }
        })
    }
}
