import Foundation
import Alamofire
import SwiftyJSON

class Alamofire {
  class Params : Encodable {}
  func alamofireRequest (requestPath: String, method: HTTPMethod, params: Params, completion: @escaping (_ json: JSON) -> ()) {
    AF.request(requestPath,
               method: method,
               parameters: params,
               encoder: JSONParameterEncoder.default).responseJSON { response in
                switch response.result{
                  case .success:
                    guard let json = response.data else{
                        return
                    }
                  completion(JSON(json))
                  case .failure(let error):
                    print("Alamofire Failed:\(error)")
                }
    }
  }
}

