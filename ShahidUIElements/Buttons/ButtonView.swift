//
//  ButtonView.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 27/08/2022.
//


import Foundation
import UIKit

class ButtonView: UIButton, UIBase, CornersRoundable {
    
    var type: ViewSkin = .secondary {
        didSet {
            setup();
        }
    }
    
    var label: String = "" {
        didSet {
            setTitle(label, for: [])
        }
    }
    
    init(type: ViewSkin){
        super.init(frame: CGRect.zero);
        commonInit();
        self.type = type;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        commonInit();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    
    func commonInit(){
        style();
        layout();
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 280.0, height: 64.0)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        setup();
    }
    
}

extension ButtonView {
    
    func setup(){
        preSetup();
        
        switch (type) {
        case .primary:
            setTitleColor(AppColors.NormalText, for: []);
            backgroundColor = .clear;
            
        case .secondary:
            setTitleColor(AppColors.NormalText, for: []);
            backgroundColor = .clear;
            
        case .disabled:
            backgroundColor = AppColors.DisabledBackground;
            setTitleColor(AppColors.DisabledText, for: []);
            
        case .normal:
            setTitleColor(AppColors.NormalText, for: []);
            backgroundColor = .clear;
        }
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        roundCorners(K.cornerRadius)
    }
    
    func layout() {
        
    }
}
