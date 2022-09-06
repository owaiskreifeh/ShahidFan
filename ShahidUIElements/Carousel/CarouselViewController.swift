//
//  CarouselViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import UIKit;

class CarouselViewController: UIViewController {

    let hCarousel = HCarouselView();
    let playerCtrl = PlayerViewController();

    override func viewDidLoad() {
        super.viewDidLoad();
        hCarousel.onChannelTouch = onChannelTouch(_:);
        style();
        layout();
    }
    
    func onChannelTouch(_ channel: Channel) {
        playerCtrl.assetUri = channel.url;
        navigationController?.pushViewController(playerCtrl, animated: true)
    }
    
}

extension CarouselViewController {
    func style(){
        view.backgroundColor = AppColors.BoxBackground;
    }
    
    func layout(){
        view.addSubview(hCarousel);
        
        NSLayoutConstraint.activate([
            hCarousel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hCarousel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hCarousel.heightAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}
