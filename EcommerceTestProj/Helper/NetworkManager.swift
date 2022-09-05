import Foundation
import Alamofire

class NetworkManager {
    
    func fetchData(url:URL,completion: @escaping (AFDataResponse<Data?>) -> Void) {
        let _ = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response(completionHandler: { responseData in
                completion(responseData)
        })
    }
}
