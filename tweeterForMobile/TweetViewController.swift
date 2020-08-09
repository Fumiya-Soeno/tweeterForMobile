import UIKit

class TweetViewController: UIViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
       TweetTextFieldOutlet.becomeFirstResponder()
  }
  
  @IBOutlet weak var TweetTextFieldOutlet: UITextField!
  @IBAction func CancelButtonAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
