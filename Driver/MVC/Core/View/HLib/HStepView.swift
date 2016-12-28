//
//  HStepView.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/19/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//


import UIKit

protocol StepViewDelegate {
    func stepViewDidClickToStep(sender: HStepView, index: Int)
}

@IBDesignable class HStepView: UIView {
    
//    var _numberStep = 4
//    var _normalColor = UIColor.RGB(231, green: 231, blue: 231)
//    var _highlightColor = UIColor.RGB(50, green: 50, blue: 50)
//    var _height: CGFloat = 3
    
    
    var listCircleShape = [CAShapeLayer]()
    @IBInspectable var R: CGFloat = 7
    @IBInspectable var numberStep: Int = 4
    @IBInspectable var drawLine: Bool = true
    @IBInspectable var normalColor: UIColor = UIColor.RGB(red: 231, green: 231, blue: 231)
    @IBInspectable var margin: CGFloat = 15
    @IBInspectable var highlightColor: UIColor = UIColor.RGB(red: 50, green: 50, blue: 50)
    @IBInspectable var height: CGFloat = 40
    
    @IBInspectable var currentStep: Int = 1 {
        didSet {
            draw(frame)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initControl()
    }
    
    func initControl() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(HStepView.didClick(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    func didClick(sender: UITapGestureRecognizer) {
        var index = 0
        let x = sender.location(in: self).x
        
        let d = (self.frame.width - margin * 2)/CGFloat(numberStep - 1)
        if 0...margin + d/2 ~= x { //first
            index = 1
        } else if frame.width-margin-d/2...frame.width ~= x { //last
            index = numberStep
        } else {    //center
            index = Int((x - margin-d/2)/d) + 2
        }
        
        delegate?.stepViewDidClickToStep(sender: self, index: index)
    }
    
    func roundCGFloat(float: CGFloat) -> Int {
        if float - CGFloat(Int(float)) > 0.5 {
            return Int(float - CGFloat(Int(float)) + 1.0)
        } else {
            return Int(float - CGFloat(Int(float)))
        }
    }
    
    var delegate: StepViewDelegate? = nil
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.layer.sublayers != nil {
            for shape in self.layer.sublayers! {
                shape.removeFromSuperlayer()
            }
        }
        listCircleShape.removeAll()
        
        let y = (frame.height - height)/2
        _ = CGPoint(x: margin, y: y)
        _ = CGPoint(x: frame.width - margin, y: y)
        if drawLine == true {
//            drawLine(start, endPoint: end)
        }
        let d = (frame.width - margin * 2)/CGFloat(numberStep - 1)
        
        for i in 0 ..< numberStep {
            let point = CGPoint(x: margin + d * CGFloat(i), y: y)
            if i + 1 == currentStep {
                listCircleShape.append(drawCircle(center: point, R: R, color: highlightColor))
            } else {
                listCircleShape.append(drawCircle(center: point, R: R, color: normalColor))
            }
        }
    }
    
    func drawLine(startPoint: CGPoint, endPoint: CGPoint) {
        let path = CGMutablePath()
        path.move(to: startPoint)
        path.move(to: endPoint)
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.strokeColor = normalColor.cgColor
        shape.lineWidth = 2
        layer.addSublayer(shape)
    }
    
    func drawCircle(center: CGPoint, R: CGFloat, color: UIColor) -> CAShapeLayer {
        let circlePath = UIBezierPath(arcCenter: center, radius: R, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let shapeCircle = CAShapeLayer()
        shapeCircle.path = circlePath.cgPath
        shapeCircle.fillColor = color.cgColor
        layer.addSublayer(shapeCircle)
        
        return shapeCircle
    }
}
