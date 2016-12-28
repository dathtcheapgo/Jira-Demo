import UIKit

@IBDesignable class HBorderButton: UIButton {
    
    let gradient = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if gradientTopColor != nil && gradientBotColor != nil {
            gradient.removeFromSuperlayer()
            gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            gradient.colors = [gradientTopColor!.cgColor, gradientBotColor!.cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        
            self.layer.insertSublayer(gradient, at: 0)
        } else if gradientLeftColor != nil && gradientRightColor != nil {
            gradient.removeFromSuperlayer()
            gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            gradient.colors = [gradientLeftColor!.cgColor, gradientRightColor!.cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
            
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    @IBInspectable var gradientTopColor: UIColor? = nil
    @IBInspectable var gradientBotColor: UIColor? = nil
    @IBInspectable var gradientLeftColor: UIColor? = nil
    @IBInspectable var gradientRightColor: UIColor? = nil
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var enableShadow: Bool = false {
        didSet {
            if enableShadow == true {
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 5
                self.layer.shadowOpacity = 0.9
            }
        }
    }
}
