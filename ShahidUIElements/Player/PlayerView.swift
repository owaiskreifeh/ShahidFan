//
//  Player.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//


import UIKit
import AVFoundation;


protocol PlayerViewDelegate {
    func playerItemChange(_ playerItem: AVPlayerItem?, sender: AVPlayer);
    func playerTimeUpdate(_ time: CMTime, sender: AVPlayer);
    func playerDurationChange(_ time: CMTime, sender: AVPlayer);
    func playerSeekRangeChange(_ ranges: [NSValue], sender: AVPlayer);
}

class PlayerView: UIView {
    
    var observers: [NSKeyValueObservation] = [];
    
    let avPlayer = AVPlayer();
    let avPlayerLayer = AVPlayerLayer();
    var timeObserverToken: Any?
    
    
    var delegate: PlayerViewDelegate! {
        didSet {
            onPlayerItemChange(avPlayer.currentItem);
        }
    }
    
    var videoUri: String = "" {
        didSet {
            setup();
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        avPlayerLayer.player = avPlayer;
        layer.insertSublayer(avPlayerLayer, at: 0);
        setup();
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 200.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avPlayerLayer.frame = bounds;
    }
    
    deinit {
        removeObservers();
    }
}

extension PlayerView {
    func setup() {
        let url = URL(string: videoUri);
        if let url = url {
            let avPlayerItem = AVPlayerItem(url: url);
            avPlayer.replaceCurrentItem(with: avPlayerItem);
            addObservers();
            avPlayer.play()
        }
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout() {
        
    }
    
}


// MARK: - Ctrls

extension PlayerView {
    func addObservers() {
        
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        timeObserverToken = avPlayer.addPeriodicTimeObserver(forInterval: time, queue: .main) {
            [weak self] time in
            self?.onTimeUpdate(time);
        }
        
        
        if let playerItem = avPlayer.currentItem {
            
            observers.append(playerItem.observe(\.status, options: [.new, .old], changeHandler: { player, value in
                print("status",value)
            }))
            
            
            observers.append(playerItem.observe(\.duration, options: [.new, .old], changeHandler: { [weak self] player, value in
                if let duration = value.newValue {
                    self?.onDurationChange(duration)
                }
            }))
            
            observers.append(playerItem.observe(\.loadedTimeRanges, options: [.new, .old], changeHandler: { [weak self] player, value in
                if let ranges = value.newValue {
                    self?.onSeekableRangeChange(ranges)
                }
            }))
           
        }
    }
    
    func removeObservers() {
        if let timeObserverToken = timeObserverToken {
                avPlayer.removeTimeObserver(timeObserverToken)
                self.timeObserverToken = nil
            }
    }
    
    func onTimeUpdate(_ time: CMTime) {
        delegate?.playerTimeUpdate(time, sender: avPlayer)
    }
    
    func onDurationChange(_ time: CMTime) {
        delegate?.playerDurationChange(time, sender: avPlayer)
    }
    
    func onSeekableRangeChange(_ ranges: [NSValue]) {
        delegate?.playerSeekRangeChange(ranges, sender: avPlayer)
    }
    
    func onPlayerItemChange(_ playerItem: AVPlayerItem?){
        delegate?.playerItemChange(playerItem, sender: avPlayer);
    }
}
