//
//  Base.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//

import UIKit;


enum ViewSkin {
    case normal, primary, secondary, disabled;
}

// MARK: - UIBase element
protocol UIBase where Self: UIView {
    var type: ViewSkin {
        get set
    }
    func setup();
}

extension UIBase {
    
    func preSetup() {
        removeGradients();

        switch (type) {
        case .primary:
            setGradientBackground(AppColors.GradientColors);
            
        case .secondary:
            setGradientBorder(AppColors.GradientColors, storkWidth: 4);
            
        case .disabled:
            backgroundColor = AppColors.DisabledBackground;
            
        case .normal:
            break;
        }
    }
}


// MARK: - Blinkable

protocol Blinkable where Self: UIView {
    func blink()
}

extension Blinkable  {
    func blink() {
        alpha = 1

        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [.repeat, .autoreverse],
            animations: {
                self.alpha = 0
        })
    }
}

// MARK: - Scalable

protocol Scalable where Self: UIView {
    func scale()
}

extension Scalable {
    func scale() {
        transform = .identity

        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [.repeat, .autoreverse],
            animations: {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
    }
}

// MARK: - CornersRoundable

protocol CornersRoundable where Self: UIView {
    func roundCorners(_ by: CGFloat?)
}

extension CornersRoundable {
    func roundCorners(_ by: CGFloat?) {
        layer.cornerRadius = by ?? (bounds.width * 0.1)
        clipsToBounds = true
    }
}
