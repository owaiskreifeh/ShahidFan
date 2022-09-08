//
//  HCard.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import Foundation
import UIKit

class HCardCell: UITableViewCell  {
    
    let id = K.HCardCellId;
    let logoImageView = UIImageView();
    let label = UILabel();
    let subView = BoxView(type: .normal)
    
    var imageUrl = "" {
        didSet {
            logoImageView.fetchRemote(url: imageUrl);
            logoImageView.contentMode = .scaleAspectFit
        }
    }
    
    var title = "" {
        didSet {
            label.text = title;
            label.textAlignment = .center;
        }
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        transform = CGAffineTransform(rotationAngle: 1.57079632679)
        
        setup(); // @TODO:
        layout(); // @TODO:
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 400)
    }
}

extension HCardCell {
    
    func setup() {
                
        logoImageView.translatesAutoresizingMaskIntoConstraints = false;
        label.translatesAutoresizingMaskIntoConstraints = false;
        subView.translatesAutoresizingMaskIntoConstraints = false;

        backgroundColor = .clear;
        contentView.backgroundColor = .clear
        
        subView.addBlurEffect(style: .light)
    }
    
    func layout() {
        contentView.addSubview(subView);
        subView.addSubview(logoImageView);
        subView.addSubview(label);
        
        NSLayoutConstraint.activate([
        
            subView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: subView.trailingAnchor, multiplier: 1),
            subView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: subView.bottomAnchor, multiplier: 2),
            // logo image
            logoImageView.topAnchor.constraint(equalTo: subView.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            subView.bottomAnchor.constraint(equalToSystemSpacingBelow: logoImageView.bottomAnchor, multiplier: 4),
            
            // label title
            label.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            label.topAnchor.constraint(equalToSystemSpacingBelow: logoImageView.bottomAnchor, multiplier: 0),
            label.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
        ])
        
    }
    
}
