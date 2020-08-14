import UIKit

let alamofire = alamofireRequest()
var safeAreaHeight = 0
var tweetString: String = ""

struct TweetParams : Encodable {
  let text : String
}

class ViewController: UIViewController {
  let screenSize = UIScreen.main.bounds.size
  let statusBarHeight = Int(UIApplication.shared.statusBarFrame.size.height)
  let TweetView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 400))
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "tweetViewSegue" {
      let tweetViewController = segue.destination as! TweetViewController
      tweetViewController.TweetView = TweetView
      tweetViewController.stackViewHeight = Int(ButtonStackViewOutlet.bounds.height)
    }
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if #available(iOS 11.0, *) {
      safeAreaHeight = Int(self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom)
    }
    let stackViewHeight = Int(ButtonStackViewOutlet.bounds.height)
//    TweetView.bounds.size.height = UIScreen.main.bounds.size.height - CGFloat(statusBarHeight + stackViewHeight + safeAreaHeight)
//    print("safeAreaHeight:\(safeAreaHeight), statusBarHeight:\(statusBarHeight), stackViewHeight:\(stackViewHeight)")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(TweetView)
    self.view.bringSubviewToFront(TweetButtonOutlet)
    alamofire.tweet(params: alamofireRequest.TweetParams(text: ""), view: TweetView, screenSize: screenSize)
  }
  
  @IBOutlet weak var ButtonStackViewOutlet: UIStackView!
  @IBOutlet weak var TweetButtonOutlet: UIButton!
  @IBAction func tweetButtonAction(_ sender: Any) {
    self.performSegue(withIdentifier: "tweetViewSegue", sender: self)
  }
  
}
