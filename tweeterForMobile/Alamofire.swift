import Alamofire
import SwiftyJSON

class alamofireRequest{
  var tweetPreviews = Array<UITextView>()
  struct TweetParams : Encodable {
    let text : String
  }
  
  func tweet(params: TweetParams, view: UIScrollView, screenSize: CGSize){
    AF.request("http://localhost:3000/api/tweets",
               method: .post,
               parameters: params,
               encoder: JSONParameterEncoder.default).responseJSON { response in
                switch response.result{
                  case .success:
                    guard let json = response.data else{ return }
                    var count = 1
                    for tweets in JSON(json)["tweet"] {
                      let tweetPreview = UITextView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 28))
                      tweetPreview.text = "\(tweets.1["created_at"]) \(tweets.1["text"])"
                      tweetPreview.textColor = .black
                      tweetPreview.backgroundColor = .green
                      tweetPreview.isEditable = false
                      tweetPreview.layer.position = CGPoint(x: Int(screenSize.width)/2, y: 29*(count)-13)
                      self.tweetPreviews.append(tweetPreview)
                      count += 1
                    }
                    for tweetPreview in self.tweetPreviews{
                      view.addSubview(tweetPreview)
                    }
                    view.contentSize = CGSize(width: Int(screenSize.width), height: (self.tweetPreviews.count)*29)
                  case .failure(let error):
                    print("Alamofire Failed:\(error)")
                }
    }
  }
}
