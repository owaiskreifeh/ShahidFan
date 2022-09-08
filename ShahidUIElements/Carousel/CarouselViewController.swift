//
//  CarouselViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import UIKit;
import M3UKit

class CarouselViewController: UIViewController {
    
    
    let scrollView = UIScrollView();
    let contentView = UIView();
    
    var carousels: [HCarouselView] = [];
    let spinner = SpinnerView();
    
    let playerCtrl = PlayerViewController();
    
    let stackView = UIStackView();
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        style();
        layout();
        
        spinner.animate()
        
        let group = DispatchGroup();
        
//        group.enter();
//        fetchCarousel("https://raw.githubusercontent.com/owaiskreifeh/jsons_snippets/main/vod-hls.json") { result in
//            switch result {
//            case .failure(let error):
//                print("Error while fetching channels, ", error);
//            case .success(let channelsArray):
//                let carousel = HCarouselView();
//                carousel.items = channelsArray;
//                self.carousels.append(carousel);
//            }
//            group.leave();
//
//        }
//
//        group.enter()
//        fetchCarousel("https://raw.githubusercontent.com/owaiskreifeh/jsons_snippets/main/live_channels.json") { result in
//            switch result {
//            case .failure(let error):
//                print("Error while fetching channels, ", error);
//            case .success(let channelsArray):
//                let carousel = HCarouselView();
//                carousel.items = channelsArray;
//                self.carousels.append(carousel);
//            }
//
//            group.leave();
//        }
//
        
        group.enter()
        [
            "https://iptv-org.github.io/iptv/regions/mena.m3u",
            "https://iptv-org.github.io/iptv/categories/movies.m3u",
            "https://iptv-org.github.io/iptv/categories/music.m3u",
            "https://iptv-org.github.io/iptv/categories/sports.m3u",
            "https://iptv-org.github.io/iptv/categories/documentary.m3u",
        ].forEach { urlString in
            let carousel = HCarouselView();
            carousel.buildFromPlaylistUrl(urlString);
            carousels.append(carousel);
        }
        
        group.leave();
        
        group.notify(queue: .main) { [unowned self] in
            self.spinner.stop();
            self.carousels.forEach { carousel in
                carousel.onChannelTouch = onChannelTouch(_:);
                carousel.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true;
                stackView.addArrangedSubview(carousel)
            }
        }
    }
    
    func onChannelTouch(_ channel: Channel) {
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
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false;
        contentView.translatesAutoresizingMaskIntoConstraints = false;
        
//        scrollView.backgroundColor = .red;
//        contentView.backgroundColor = .blue;
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical
        stackView.distribution = .fillEqually;
        stackView.alignment = .fill;
    }
    
    func layout(){
        
        view.addSubview(scrollView)
        view.addSubview(spinner);
        
        scrollView.addSubview(contentView);
        contentView.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),

            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow

        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
    }
}
