//
//  PlayerViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//

import UIKit;
import AVFoundation;

class PlayerViewController: UIViewController {
    
    let stackView = UIStackView();
    let label = UILabel();
    let playerView = PlayerView();
    let playerUIView = PlayerUIView();
    
    var assetUri = "http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8" {
        didSet {
            playerView.videoUri = assetUri
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        style();
        layout();
        
        playerView.avPlayer.volume = 1;
        
        playerView.delegate = playerUIView;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        AppUtility.lockOrientation(.landscape)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        playerView.avPlayer.replaceCurrentItem(with: nil)
    }

}

extension PlayerViewController {
    
    func style(){
        playerView.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = AppColors.BoxBackground;
    }
    
    func layout(){
        view.addSubview(playerView);
        view.addSubview(playerUIView);
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            playerUIView.topAnchor.constraint(equalTo: view.topAnchor),
            playerUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
