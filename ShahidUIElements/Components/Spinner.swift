//
//  UpsellModalView.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 07/09/2022.
//


import Foundation
import UIKit

class SpinnerView: UIView {
    
    let imageView = UIImageView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 64, height: 64)
    }
    
}

extension SpinnerView {
    
    func setup() {
        imageView.image = UIImage(named: "LoadingSpinner")
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFit;
    }
    
    func layout() {
        addSubview(imageView);
        
        NSLayoutConstraint.activate([
            
            widthAnchor.constraint(equalToConstant: 64),
            heightAnchor.constraint(equalToConstant: 64),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func animate() {
        UIView.animate(withDuration: 1000, delay: 0) {
            self.alpha = 1;
        }
        imageView.rotateWithAnimation(angle: .pi*2, duration: 0.4, repeatCount: .infinity)
    }
    
    func stop() {
        self.alpha = 0;
        imageView.stopRotateAnimation();
    }
}
