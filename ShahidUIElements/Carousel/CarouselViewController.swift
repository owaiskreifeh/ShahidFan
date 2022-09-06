//
//  CarouselViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import UIKit;

class CarouselViewController: UIViewController {

    let hCarousel1 = HCarouselView();
    let hCarousel2 = HCarouselView();

    let playerCtrl = PlayerViewController();

    override func viewDidLoad() {
        super.viewDidLoad();
        hCarousel1.onChannelTouch = onChannelTouch(_:);
        hCarousel2.onChannelTouch = onChannelTouch(_:);

        style();
        layout();
        
        fetchCarousel("https://raw.githubusercontent.com/owaiskreifeh/jsons_snippets/main/vod-hls.json") { result in
            switch result {
            case .failure(let error):
                print("Error while fetching channels, ", error);
            case .success(let channelsArray):
                self.hCarousel1.items = channelsArray;
            }
        }
        
        fetchCarousel("https://raw.githubusercontent.com/owaiskreifeh/jsons_snippets/main/live_channels.json") { result in
            switch result {
            case .failure(let error):
                print("Error while fetching channels, ", error);
            case .success(let channelsArray):
                self.hCarousel2.items = channelsArray;
            }
        }
    }
    
    func onChannelTouch(_ channel: Channel) {
        print("is Modal", isModal)
        playerCtrl.assetUri = channel.url;

        if (isModal) {
            playerCtrl.modalPresentationStyle = .formSheet;
            present(playerCtrl, animated: true)
        } else {
            navigationController?.pushViewController(playerCtrl, animated: true)
        }
        
    }
    
}

extension CarouselViewController {
    func style(){
        if (isModal) {
            view.addBlurEffect(style: .dark)
        } else {
            view.backgroundColor = AppColors.BoxBackground;
        }
    }
    
    func layout(){
        view.addSubview(hCarousel1);
        view.addSubview(hCarousel2);

        NSLayoutConstraint.activate([
            hCarousel1.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            hCarousel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hCarousel1.heightAnchor.constraint(equalToConstant: 200),
            hCarousel1.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            
            hCarousel2.topAnchor.constraint(equalToSystemSpacingBelow: hCarousel1.bottomAnchor, multiplier: 0),
            hCarousel2.heightAnchor.constraint(equalToConstant: 200),
            hCarousel2.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

        ])
    }
}
