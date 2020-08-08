import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  @IBAction func CancelButtonAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}
