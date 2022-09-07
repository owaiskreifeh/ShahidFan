//
//  UIViewGragient.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 27/08/2022.
//

import UIKit;

extension UIView {
    
    func setGradientBackground(_ colors: [UIColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = bounds;
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBorder(_ colors: [UIColor], storkWidth: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  bounds;
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let shape = CAShapeLayer()
        shape.lineWidth = storkWidth;
        shape.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath;
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = shape
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradients(){
        layer.sublayers?.forEach({ subLayer in
            if subLayer is CAGradientLayer {
                subLayer.removeFromSuperlayer();
            }
        })
    }
    
    
    func addBlurEffect(style: UIBlurEffect.Style){
        backgroundColor = .clear;
        let blurEffect = UIBlurEffect(style: style)
        
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(blurView, at: 0);
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.heightAnchor.constraint(equalTo: heightAnchor),
            blurView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    
    func rotateWithAnimation(angle: CGFloat, duration: CGFloat? = nil, repeatCount: Float = 1) {
        let pathAnimation = CABasicAnimation(keyPath: "transform.rotation")
        pathAnimation.duration = CFTimeInterval(duration ?? 2.0)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = angle
        pathAnimation.repeatCount = repeatCount;
        self.transform = transform.rotated(by: angle)
        self.layer.add(pathAnimation, forKey: "transform.rotation")
    }
    
    func stopRotateAnimation(){
        self.layer.removeAllAnimations();
    }
}
