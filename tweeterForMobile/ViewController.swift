import UIKit

var tweetString: String = ""

struct TweetParams : Encodable {
  let text : String
}

class ViewController: UIViewController {
  let screenSize = UIScreen.main.bounds.size
  func callBack() {
    let TweetSecondView = UIView(frame: CGRect(x: 0, y: 0, width: self.screenSize.width, height: 40))
    TweetSecondView.backgroundColor = UIColor(red: 0.1, green: 0.5, blue: 1.0, alpha: 1.0)
    TweetView.addSubview(TweetSecondView)
    let TweetTextLabel = UILabel(frame: CGRect(x: 5, y: 5, width: 200, height: 30))
    TweetTextLabel.text = tweetString
    TweetSecondView.addSubview(TweetTextLabel)
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
