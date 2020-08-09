import Foundation
import UIKit

@IBDesignable
public final class PlaceHolderTextView: UITextView {
    
    // MARK: - IBInspectable
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable
    public var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    /// プレースホルダー表示用の文字列
    /// 本プロパティの値がプレースホルダーとして表示される
    @IBInspectable
    public var placeHolder: String? {
        didSet {
            placeHolderLabel.text = placeHolder
        }
    }
    
    /// 本来持っているtextプロパティを上書きして、didSetをつけている
    /// このようにすることで、UITextViewの初期値に
    /// textが入っていた際にプレースホルダーを非表示にできる
    public override var text: String! {
        didSet {
            placeHolderLabel.isHidden = !text.isEmpty
            placeHolderLabel.sizeToFit()
        }
    }
    
    private let placeHolderLabel = UILabel(frame: .zero)
    
    // MARK: - Life Cycle
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
        
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: nil)
    }
}

private extension PlaceHolderTextView {
    
    private func commonInit() {
        
        // PlaceHolder表示用のラベルをUITextViewに加えConstraintをつける
        layer.masksToBounds = true
        addSubview(placeHolderLabel)
        
        // TextViewのtextと位置が同じになるように、
        // textContainerInsetとlineFragmentPaddingを考慮してConstraintをかける
        let padding = textContainer.lineFragmentPadding
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false

        placeHolderLabel.topAnchor.constraint(equalTo: topAnchor
            , constant: textContainerInset.top).isActive = true
        placeHolderLabel.leadingAnchor.constraint(equalTo: leadingAnchor
            , constant: textContainerInset.left + padding).isActive = true
        placeHolderLabel.bottomAnchor.constraint(equalTo:  bottomAnchor
            , constant: textContainerInset.bottom).isActive = true
        placeHolderLabel.trailingAnchor.constraint(equalTo: trailingAnchor
            , constant: textContainerInset.right + padding).isActive = true
        
        let widthConstant = (textContainerInset.left + textContainerInset.right + padding * 2)
        placeHolderLabel.widthAnchor.constraint(equalTo: widthAnchor
            , constant: -widthConstant).isActive = true
        
        // Fontカラーはgrayにしていますが、必要に応じて変更してください
        placeHolderLabel.font = font
        placeHolderLabel.textColor = UIColor.gray
        placeHolderLabel.numberOfLines = 0
        placeHolderLabel.text = placeHolder

        // Observations
        // UITextViewの編集イベントを受け取るためにKVOの設定をしています
        // UITextViewの編集を始めるとプレースホルダーが消え、
        // 編集完了すると、textの中身をみてプレースホルダーを表示するか判断します
        NotificationCenter.default.addObserver(self, selector: #selector(hidePlaceHolder), name: UITextView.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changePlaceholderVisibility), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func hidePlaceHolder() {
      if self.text! != "" {
        placeHolderLabel.isHidden = true
      }
    }
    
    @objc func changePlaceholderVisibility() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
