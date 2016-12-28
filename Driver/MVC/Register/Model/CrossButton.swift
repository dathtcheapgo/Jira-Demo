//
//  ForwardButton.swift
//  TuneOnProject
//
//  Created by Tien Dat on 10/29/16.
//  Copyright © 2016 Dinh Anh Huy. All rights reserved.
//

import UIKit

private let whiteColor = UIColor(
    red: 255.0 / 255.0,
    green: 255.0 / 255.0,
    blue: 255.0 / 255.0,
    alpha: 1.0
)


@IBDesignable public class CrossButton: UIButton {
    
    
    private var CrossShapeLayer: CAShapeLayer = CAShapeLayer()

    @IBInspectable public var playColor: UIColor = whiteColor
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    private func sharedInit() {
        
        layer.cornerRadius = frame.size.width / 2 + 1
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = UIColor(netHex: 0x5d5d5d)
        clipsToBounds = true
        layer.borderWidth = 1.0

        print("created Cross Button")
    }
    
    override public func draw(_ rect: CGRect) {
        
        let midY = rect.midY
        let playLeftX = rect.midX
        
        let crossPath = UIBezierPath()
        crossPath.lineJoinStyle = CGLineJoin.round
        
        crossPath.move(to: CGPoint(x: playLeftX, y: midY))
        crossPath.addLine(to: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.75))
        crossPath.move(to: CGPoint(x: playLeftX, y: midY))
        crossPath.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY / 4))
        crossPath.move(to: CGPoint(x: playLeftX, y: midY))
        crossPath.addLine(to: CGPoint(x: rect.maxX * 0.75, y: rect.maxY / 4))
        crossPath.move(to: CGPoint(x: playLeftX, y: midY))
        crossPath.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY * 0.75))
    

        
        CrossShapeLayer.path = crossPath.cgPath
        CrossShapeLayer.strokeColor = playColor.cgColor
        CrossShapeLayer.fillColor = playColor.cgColor

        self.layer.addSublayer(CrossShapeLayer)
        

    }

    

    
    func animate() {
        let t1 = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.transform = t1
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.225, initialSpringVelocity: 0.7, options: .beginFromCurrentState, animations: { () -> Void in
            let t2 = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.transform = t2
            }, completion: { (b) -> Void in
                //
        })
    }
    
}
