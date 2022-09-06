//
//  PlayPauseView.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 05/09/2022.
//

import Foundation
import UIKit


protocol PlayPauseViewDelegate {
    func playPauseTouched(_ sender: PlayPauseView);
}

class PlayPauseView: UIView {
    
    var delegate: PlayPauseViewDelegate?;
    
    var didTouchBegin = false;
    let imageView = UIImageView();
    
    var isPaused = false {
        didSet {
            if (isPaused) {
                imageView.image = UIImage(systemName: "play")
            } else {
                imageView.image = UIImage(systemName: "pause")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        isUserInteractionEnabled = true;
        imageView.tintColor = .white
        style(); // @TODO:
        layout(); // @TODO:
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 200.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouchBegin = true;
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouchBegin = false;
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouchBegin = false;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (didTouchBegin) {
            didTouchBegin = false;
            delegate?.playPauseTouched(self)
        }
    }
}

extension PlayPauseView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = UIImage(systemName: "pause")

    }
    
    func layout() {
        addSubview(imageView);
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 72),
            imageView.heightAnchor.constraint(equalToConstant: 72),

        ])
    }
    
}
