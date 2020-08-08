import Alamofire
import SwiftyJSON

class alamofireRequest{
  
  struct TweetParams : Encodable {
    let text : String
  }
  
  func tweet(params: TweetParams){
    AF.request("http://localhost:3000/api/tweets",
               method: .post,
               parameters: params,
               encoder: JSONParameterEncoder.default).responseJSON { response in
                switch response.result{
                  case .success:
                    guard let json = response.data else{
                        return
                    }
                    print(JSON(json))
                  case .failure(let error):
                    print("Alamofire Failed:\(error)")
                }
    }
  }
}
