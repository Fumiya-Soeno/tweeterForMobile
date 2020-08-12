import UIKit

class TweetViewController: UIViewController, UITextViewDelegate{
  var childCallBack: (() -> Void)?
  let alamofire = alamofireRequest()
  var keyboardHeight = 0
  var safeAreaHeight = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    TweetButtonOutlet.layer.cornerRadius = 13
    TweetTextViewOutlet.delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      keyboardHeight = Int(keyboardSize.height)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    TweetTextViewOutlet.becomeFirstResponder()
  }
  
  @IBOutlet weak var TweetTextViewOutlet: PlaceHolderTextView!
  @IBOutlet weak var TweetTextViewHeightOutlet: NSLayoutConstraint!
  @IBOutlet weak var TweetButtonOutlet: UIButton!
  @IBAction func TweetButtonAction(_ sender: Any) {
    let tweet = TweetTextViewOutlet.text
    if(tweet != ""){
      self.dismiss(animated: true, completion: {
        tweetString = tweet!
        self.alamofire.tweet(params: alamofireRequest.TweetParams(text: tweetString))
        self.childCallBack?()
        tweetString = ""
      })
    }
  }
  
  func textViewDidChangeSelection(_ textView: UITextView){
    if #available(iOS 11.0, *) {
        let safeAreaTop = self.view.safeAreaInsets.top
        let safeAreaBottom = self.view.safeAreaInsets.bottom
      safeAreaHeight = Int(safeAreaTop + safeAreaBottom)
    }
    let frameHeight: Int = Int(self.view.bounds.height) - keyboardHeight - safeAreaHeight - 39
    if Int(textView.contentSize.height) > frameHeight {
      TweetTextViewHeightOutlet.constant = CGFloat(frameHeight)
    }
  }
  
  @IBAction func CancelButtonAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}
