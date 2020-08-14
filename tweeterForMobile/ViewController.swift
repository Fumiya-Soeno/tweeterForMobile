import UIKit
import SnapKit

let alamofire = alamofireRequest()
var tweetString: String = ""

struct TweetParams : Encodable {
  let text : String
}

class ViewController: UIViewController {
  let screenSize = UIScreen.main.bounds.size
  let TweetView = UIScrollView()
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "tweetViewSegue" {
      let tweetViewController = segue.destination as! TweetViewController
      tweetViewController.TweetView = TweetView
      tweetViewController.stackViewHeight = Int(ButtonStackViewOutlet.bounds.height)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(TweetView)
    
    TweetView.snp.makeConstraints { make in
      make.bottom.equalTo(ButtonStackViewOutlet.snp.top)
      make.left.right.top.equalToSuperview()
    }
    
    self.view.bringSubviewToFront(TweetButtonOutlet)
    alamofire.tweet(params: alamofireRequest.TweetParams(text: ""), view: TweetView, screenSize: screenSize)
  }
  
  @IBOutlet weak var ButtonStackViewOutlet: UIStackView!
  @IBOutlet weak var TweetButtonOutlet: UIButton!
  @IBAction func tweetButtonAction(_ sender: Any) {
    self.performSegue(withIdentifier: "tweetViewSegue", sender: self)
  }
  
}

