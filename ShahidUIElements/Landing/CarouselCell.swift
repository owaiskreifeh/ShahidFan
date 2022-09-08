//
//  CarouselCell.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 08/09/2022.
//

import UIKit


class CarouselCell: UITableViewCell {
    let titleLabel = UILabel();
    var carousel: CarouselView! {
        didSet {
            if (carousel != nil) {
                setup();
            }
        }
    }

    
    func setup() {
        
        titleLabel.textColor = AppColors.NormalText
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        addSubview(titleLabel);
        addSubview(carousel);
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            
            carousel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            carousel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: carousel.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: carousel.trailingAnchor, multiplier: 1),
        ])
    }
}
