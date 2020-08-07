import UIKit
import SwiftyJSON

class ViewController: UIViewController {
  let alamofire = Alamofire()
  override func viewDidLoad() {
    super.viewDidLoad()
    let params = Alamofire.Params()
    alamofire.alamofireRequest(requestPath: "http://localhost:3000/api/tweets", method: .post, params: params, completion: {_ in print("")})
  }
  
}

