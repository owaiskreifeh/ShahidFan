//
//  CCardViewCell.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 08/09/2022.
//

import UIKit

class CCardViewCell: UICollectionViewCell, CornersRoundable {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var fotterView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = AppColors.BoxBackground
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        roundCorners(12)
//        fotterView.addBlurEffect(style: .prominent)
    }

}
