import UIKit
import Alamofire
import SwiftyJSON

var tweetString: String = ""

struct TweetParams : Encodable {
  let text : String
}

class ViewController: UIViewController {
  let TweetSecondView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
  func callBack() {
    TweetSecondView.backgroundColor = .black
    TweetView.addSubview(TweetSecondView)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "tweetViewSegue" {
      let tweetViewController = segue.destination as! TweetViewController
      tweetViewController.childCallBack = { self.callBack() }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  @IBAction func tweetButtonAction(_ sender: Any) {
    self.performSegue(withIdentifier: "tweetViewSegue", sender: self)
  }
  
  @IBOutlet weak var TweetView: UIView!
  
}
