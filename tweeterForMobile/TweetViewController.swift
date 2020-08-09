import UIKit

class TweetViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    TweetTextViewOutlet.becomeFirstResponder()
  }
  
  
  @IBOutlet weak var TweetTextViewOutlet: PlaceHolderTextView!
  @IBAction func CancelButtonAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
