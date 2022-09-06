//
//  Box.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//

import UIKit


class BoxView: UIView, UIBase, CornersRoundable {
    
    var type: ViewSkin = .normal {
        didSet {
            setup();
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
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 280.0, height: 280.0)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        setup();
    }
    
}

extension BoxView {
    
    func setup(){
        preSetup(); // check gradients
        self.roundCorners(K.cornerRadius)
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
    }
}
