import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
  let alamofire = alamofireRequest()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    alamofire.tweet(params: alamofireRequest.TweetParams(text: "test"))
  }
  
  
  @IBAction func tweetButtonAction(_ sender: Any) {
    self.performSegue(withIdentifier: "tweetViewSegue", sender: self)
  }
  
}
