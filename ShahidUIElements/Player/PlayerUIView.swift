//
//  PlayerUI.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//

import AVFoundation
import UIKit

class PlayerUIView: UIView {
    
    var player: AVPlayer?;
    var playerItem: AVPlayerItem?;
    
    let progressBar = PlayerProgressBarView();
    let playPauseView = PlayPauseView();
    
    let seekForwardButton = UIButton(type: .custom);
    let seekBackwardButton = UIButton(type: .custom);
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        playPauseView.delegate = self;
        progressBar.delegate = self;
        setup();
        style(); // @TODO:
        layout(); // @TODO:
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 200.0)
    }
}

extension PlayerUIView {
    
    func setup(){
        seekForwardButton.addTarget(self, action: #selector(seekTapped), for: .touchDownRepeat)
        seekBackwardButton.addTarget(self, action: #selector(seekTapped), for: .touchDownRepeat)
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        backgroundColor = AppColors.Backdrop;

        
        seekForwardButton.translatesAutoresizingMaskIntoConstraints = false;
//        seekForwardButton.backgroundColor = .red;

        seekBackwardButton.translatesAutoresizingMaskIntoConstraints = false;
//        seekBackwardButton.backgroundColor = .green;

    }
    
    func layout() {
        addSubview(progressBar);
        addSubview(playPauseView);
        
        addSubview(seekForwardButton);
        addSubview(seekBackwardButton);
        
        NSLayoutConstraint.activate([
            
            // progressbar
            progressBar.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 4),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: progressBar.trailingAnchor, multiplier: 4),
            bottomAnchor.constraint(equalToSystemSpacingBelow: progressBar.bottomAnchor, multiplier: 2),
            progressBar.heightAnchor.constraint(equalToConstant: 128),
            
            // playpause view
            playPauseView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 16),
            trailingAnchor.constraint(equalToSystemSpacingAfter: playPauseView.trailingAnchor, multiplier: 16),
            playPauseView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 8),
            bottomAnchor.constraint(equalToSystemSpacingBelow: playPauseView.bottomAnchor, multiplier: 16),
            
            
            seekForwardButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 16),
            trailingAnchor.constraint(equalToSystemSpacingAfter: seekForwardButton.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: seekForwardButton.bottomAnchor, multiplier: 16),
            seekForwardButton.widthAnchor.constraint(equalToConstant: 120),
            
            seekBackwardButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 16),
            leadingAnchor.constraint(equalToSystemSpacingAfter: seekBackwardButton.leadingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: seekBackwardButton.bottomAnchor, multiplier: 16),
            seekBackwardButton.widthAnchor.constraint(equalToConstant: 120),

        ])
    }
    
}


// MARK: - Actions
extension PlayerUIView {
    @objc func seekTapped(_ sender: UIButton, event: UIEvent){
        let seekTime = (player?.currentTime().seconds ?? 0) + (sender == seekForwardButton ? 10 : -10)
        player?.seek(to: CMTime(seconds: seekTime, preferredTimescale: 60000))
    }
}

// MARK: - PlayerViewDelegate

extension PlayerUIView: PlayerViewDelegate {
    func playerTimeUpdate(_ time: CMTime, sender: AVPlayer) {
        progressBar.currentTime = time.seconds;
    }
    
    func playerDurationChange(_ time: CMTime, sender: AVPlayer) {
        progressBar.duration = time.seconds;
    }
    
    func playerSeekRangeChange(_ ranges: [NSValue], sender: AVPlayer) {
        progressBar.seekRanges = ranges
    }
    
    func playerItemChange(_ playerItem: AVPlayerItem?, sender: AVPlayer) {
        self.player = sender;
        if let newPlayerItem = playerItem {
            self.playerItem = newPlayerItem
        }
    }
}

// MARK: - PlayPauseViewDelegate

extension PlayerUIView: PlayPauseViewDelegate {
    func playPauseTouched(_ sender: PlayPauseView) {
        switch player?.timeControlStatus {
        case .paused:
            player?.play();
            playPauseView.isPaused = false;
        case .playing:
            player?.pause();
            playPauseView.isPaused = true;
        default:
            print("Default status", player?.timeControlStatus)
            player?.play();
            playPauseView.isPaused = false;
        }
    }
}


extension PlayerUIView: PlayerProgressBarDelegate {
    func progressBarSeek(_ toTime: CMTime, sender: PlayerProgressBarView) {
        player?.seek(to: toTime)
    }
    
    
}
