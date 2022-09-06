//
//  ReactiveButtonView.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 07/09/2022.
//

import Foundation
import UIKit

class ReactiveButton: UIButton {
    
    var originalCenter: CGPoint?;
    var movableView = UIView();
    var backgroundView = UIImageView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        style(); // @TODO:
        layout(); // @TODO:
        
        setTitle("Go to main vc", for: [])
        backgroundView.fetchRemote(url: "https://i.pinimg.com/originals/75/22/89/75228996529e2c073a4b8cb06794ad79.png")
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(recognizePan)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 200.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

extension ReactiveButton {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.cornerRadius = K.cornerRadius;
        movableView.translatesAutoresizingMaskIntoConstraints = false;
        movableView.addBlurEffect(style: .systemUltraThinMaterial)
        
        movableView.layer.cornerRadius = K.cornerRadius;
        movableView.clipsToBounds = true
        movableView.alpha = 0
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.layer.cornerRadius = K.cornerRadius;
        backgroundView.clipsToBounds = true;

    }
    
    func layout() {
        addSubview(backgroundView);
        addSubview(movableView);

        NSLayoutConstraint.activate([
            movableView.topAnchor.constraint(equalTo: topAnchor),
            movableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movableView.trailingAnchor.constraint(equalTo: trailingAnchor),
          
            widthAnchor.constraint(equalToConstant: 186 * 2),
            heightAnchor.constraint(equalToConstant: 105 * 2),
        ])
        
        NSLayoutConstraint.activate([
            
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}

// MARK: - Actions
extension ReactiveButton {
    @objc func recognizePan(_ gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            originalCenter = movableView.center;
        case .changed:
            let translation = gesture.translation(in: self);
            
            movableView.center = CGPoint(x: translation.x / 50 + movableView.center.x, y: translation.y / 50 + movableView.center.y)
            gesture.setTranslation(CGPoint.zero, in: self);
            movableView.alpha = 1

            
        default:
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                self.movableView.frame = self.bounds;
                self.movableView.alpha = 0
            }
            
        }
    }
}
