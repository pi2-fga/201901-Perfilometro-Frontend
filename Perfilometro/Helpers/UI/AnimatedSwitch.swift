//
//  AnimatedSiwtch.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 30/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import QuartzCore

typealias VoidClosure = () -> ()

struct AnimatedSwitchConstants {
    static let animationIdentificator = "animatedSwitch"
    static let defaultBorderWidth: CGFloat = 0.5
    
    static let transformKey = "transform"
    static let animationLayerKey = "animationLayer"
}

enum AnimatedSwitchShapeType {
    case round
    case diamond
    case star
    case custom(UIBezierPath)
}

extension AnimatedSwitchShapeType {
    
    private func polygon(inCircleOfRadius radius: Double, vertices: Int, offset: Double = 0) -> [CGPoint] {
        let step = .pi * 2 / Double(vertices)
        let x: Double = 0
        let y: Double = 0
        var points = [CGPoint]()
        for i in 0...vertices {
            let xv = x - radius * cos(step * Double(i) + (step * offset))
            let yv = y - radius * sin(step * Double(i) + (step * offset))
            points.append(CGPoint(x: xv, y: yv))
        }
        return points
    }
    
    private func starShape(_ radius: Double, vertices: Int) -> UIBezierPath {
        let path = UIBezierPath()
        let externalVertices = polygon(inCircleOfRadius: radius, vertices: vertices)
        let internalVertices = polygon(inCircleOfRadius: radius/2, vertices: vertices, offset: 0.5)
        
        if externalVertices.count >= 3 {
            path.move(to: externalVertices[0])
            for i in 0..<externalVertices.count-1 {
                path.addLine(to: internalVertices[i])
                path.addLine(to: externalVertices[i + 1])
            }
            path.close()
        }
        return path
    }
    
    func scaleFactor(_ from: Double, to: CGRect) -> CGFloat {
        var endRadius: CGFloat = sqrt(to.width * to.width + to.height * to.height) / 2
        switch self {
        case .star:
            endRadius = endRadius / 2
        default:
            break
        }
        return endRadius / CGFloat(from)
    }
    
    func bezierPathInRect(_ rect: CGRect) -> UIBezierPath {
        let centerX = rect.origin.x + rect.width / 2
        let centerY = rect.origin.y + rect.height / 2
        let size = sqrt(rect.width * rect.width / 4 + rect.height *  rect.height / 4)
        switch self {
        case .diamond:
            let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size, height: size));
            path.apply(CGAffineTransform(rotationAngle: .pi/4).concatenating(CGAffineTransform(translationX: centerX, y: rect.origin.y)))
            return path
        case .star:
            let path = starShape(Double(50), vertices: 5)
            path.apply(CGAffineTransform(translationX: centerX, y: centerY))
            return path
        case .custom(let path):
            path.apply(CGAffineTransform(translationX: centerX, y: centerY))
            return path
        default:
            return UIBezierPath(ovalIn: rect)
        }
    }
}

@IBDesignable class AnimatedSwitch: UISwitch {
    
    private var originalParentBackground: UIColor?
    private var toColor: UIColor?
    private let animationIdentificator = AnimatedSwitchConstants.animationIdentificator
    private let containerLayer = CAShapeLayer()
    
    @IBInspectable var color: UIColor = .clear
    @IBInspectable var startRadius: Double = 15
    @IBInspectable var animationDuration: Double = 0.25
    
    @IBInspectable var showBorder: Bool = true
    @IBInspectable var borderColor: UIColor = .white
    
    var shape: AnimatedSwitchShapeType = .diamond
    
    
    var isAnimating: Bool = false
    var animationDidStart: VoidClosure?
    var animationDidStop: VoidClosure?
    
    private func setupView(_ parent: UIView) {
        removeTarget(self, action: #selector(AnimatedSwitch.valueChanged), for: .valueChanged)
        addTarget(self, action: #selector(AnimatedSwitch.valueChanged), for: .valueChanged)
        containerLayer.anchorPoint = CGPoint(x: 0, y: 0)
        containerLayer.masksToBounds = true
        
        parent.layer.insertSublayer(containerLayer, at: 0)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if let parent = newSuperview {
            setupView(parent)
            originalParentBackground = parent.backgroundColor
        }
    }
    
    override func layoutSubviews() {
        guard let parent = superview else { return }
        containerLayer.frame = CGRect(x: 0, y: 0, width: parent.frame.width, height: parent.frame.height)
        if isOn {
            containerLayer.backgroundColor = color.cgColor
        } else {
            containerLayer.backgroundColor = originalParentBackground?.cgColor
        }
        
        drawBorder()
    }
    
    @objc func valueChanged() {
        guard let parent = superview else { return }
        
        if isOn {
            toColor = color
        } else {
            toColor = parent.backgroundColor
        }
        
        guard let _ = toColor else { return }
        
        let correctedFrame = CGRect(x: center.x - CGFloat(startRadius), y: center.y - CGFloat(startRadius), width: CGFloat(startRadius) * 2, height: CGFloat(startRadius) * 2)
        
        let layer = CAShapeLayer()
        layer.removeAllAnimations()
        layer.bounds = correctedFrame
        layer.path = shape.bezierPathInRect(correctedFrame).cgPath
        layer.position = center
        layer.lineWidth = 0
        layer.fillColor = toColor!.cgColor
        containerLayer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: AnimatedSwitchConstants.transformKey)
        animation.duration = TimeInterval(animationDuration)
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        
        let multiplicator = shape.scaleFactor(startRadius / 2, to: parent.frame)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(multiplicator, multiplicator, 1))
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.delegate = self
        animation.setValue(layer, forKey: AnimatedSwitchConstants.animationLayerKey)
        animation.fillMode = CAMediaTimingFillMode.forwards;
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: animationIdentificator)
        
        isAnimating = true
        
        if let callback = animationDidStart {
            callback()
        }
        
        drawBorder()
    }
}

extension AnimatedSwitch: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        containerLayer.backgroundColor = toColor?.cgColor
        CATransaction.commit()
        
        if let layer = anim.value(forKey: AnimatedSwitchConstants.animationLayerKey) as? CALayer {
            layer.removeFromSuperlayer()
            isAnimating = false
        }
        
        if let callback = animationDidStop {
            callback()
        }
    }
    
    func drawBorder() {
        if showBorder && isOn {
            layer.borderWidth = AnimatedSwitchConstants.defaultBorderWidth
            layer.borderColor = borderColor.cgColor;
            layer.cornerRadius = frame.size.height / 2;
        } else {
            layer.borderWidth = 0
        }
    }
}
