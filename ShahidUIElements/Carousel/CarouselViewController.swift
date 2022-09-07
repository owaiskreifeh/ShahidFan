//
//  CarouselViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import UIKit;

class CarouselViewController: UIViewController {
    
    
    let scrollView = UIScrollView();
    let contentView = UIView();
    
    let hCarousel1 = HCarouselView();
    let hCarousel2 = HCarouselView();
    let spinner = SpinnerView();
    
    let playerCtrl = PlayerViewController();
    
    let stackView = UIStackView();
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        hCarousel1.onChannelTouch = onChannelTouch(_:);
        hCarousel2.onChannelTouch = onChannelTouch(_:);
        
        style();
        layout();
        
        spinner.animate()

        let group = DispatchGroup();
        
        group.enter();
        fetchCarousel("https://raw.githubusercontent.com/owaiskreifeh/jsons_snippets/main/vod-hls.json") { result in
            switch result {
            case .failure(let error):
                print("Error while fetching channels, ", error);
            case .success(let channelsArray):
                self.hCarousel1.items = channelsArray;
            }
            group.leave();
            
        }
        
        group.enter()
        fetchCarousel("https://raw.githubusercontent.com/owaiskreifeh/jsons_snippets/main/live_channels.json") { result in
            switch result {
            case .failure(let error):
                print("Error while fetching channels, ", error);
            case .success(let channelsArray):
                self.hCarousel2.items = channelsArray;
            }
            
            group.leave();
        }
        
        group.notify(queue: .main) {
            self.spinner.stop();
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }
    
    func layout(){
        
        view.addSubview(scrollView)
        view.addSubview(spinner);

        scrollView.addSubview(contentView);
        contentView.addSubview(stackView);

        stackView.addArrangedSubview(hCarousel1);
        stackView.addArrangedSubview(hCarousel2);
        

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.topAnchor, multiplier: 1),
            scrollView.bottomAnchor.constraint(equalToSystemSpacingBelow: contentView.bottomAnchor, multiplier: 1),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
