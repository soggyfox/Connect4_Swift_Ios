import UIKit
import Alpha0Connect4

class DiscView: UIView {
    
    private var discDropped: (action: Int, color: DiscColor, index: Int)
    private var discLabel: UILabel
    
    init(viewFrame: CGRect, moveData: (action: Int, color: DiscColor, index: Int)?) {
      self.discDropped = moveData ?? (action: 1, color: DiscColor.yellow, index: 1)

      discLabel = UILabel(frame: viewFrame)
      discLabel.center = CGPoint(x: viewFrame.width / 2, y: viewFrame.height / 2)
      discLabel.textAlignment = .center
      super.init(frame: viewFrame)
        let discColor: UIColor = self.discDropped.color == DiscColor.red ?  UIColor(red: 0.95, green: 0.1, blue: 0.1, alpha: 1)  :  UIColor(red: 1, green: 1, blue: 0.01, alpha: 1)
        let borderDiskColor: UIColor = self.discDropped.color == DiscColor.red ? UIColor(red: 0.55, green: 0.1, blue: 0.1, alpha: 1) : UIColor(red: 0.83, green: 0.89, blue: 0.12, alpha: 1)

      backgroundColor = discColor
      layer.borderColor = borderDiskColor.cgColor
      layer.cornerRadius = (viewFrame.size.width / 2.0)
      layer.borderWidth = layer.cornerRadius * 0.2
    }
    
    func displayLabel(_ indicies: [Int]?) {
        discLabel.attributedText = NSMutableAttributedString(string: "\(discDropped.index)", attributes:  [NSAttributedString.Key.strokeColor : UIColor.black])
        self.addSubview(discLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }
}
