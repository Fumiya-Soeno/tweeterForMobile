import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBDesignable
  class MyStackView: UIStackView {
      
      @IBInspectable
      var color: UIColor?
      
      override var backgroundColor: UIColor? {
          get {
              return color
          }
          set {
              color = newValue
              setNeedsLayout()
          }
      }

      private lazy var backgroundLayer: CAShapeLayer = {
          let layer = CAShapeLayer()
          self.layer.insertSublayer(layer, at: 0)
          return layer
      }()
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
          CATransaction.begin()
          CATransaction.setDisableActions(true) // CALayerの暗黙的アニメーションは不要なのでオフにする
          
          backgroundLayer.path = UIBezierPath(rect: bounds).cgPath
          backgroundLayer.fillColor = backgroundColor?.cgColor

          CATransaction.commit()
      }
  }
}

