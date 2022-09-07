//
//  PlayerProgressBar.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerProgressBarDelegate {
    func progressBarSeek(_ toTime: CMTime, sender: PlayerProgressBarView);
}

class PlayerProgressBarView: UIView {
    
    var delegate: PlayerProgressBarDelegate?;
    
    let baseSlider = UISlider();
    let seekView = UIView();
    var seekableFrags: [UIView] = [];
    let durationLabel = UILabel();
    let currentTimeLabel = UILabel();
    var isLive = false;
    var beginSeeking = false;
    
    var duration: Double = 0 {
        didSet {
            baseSlider.value = 0;
            seekableFrags.removeAll()
            if Float(duration) > baseSlider.minimumValue {
                baseSlider.maximumValue = Float(duration);
                durationLabel.text = AppUtility.secondsToHMS(duration)
                isLive = false;
                durationLabel.backgroundColor = .clear;
                durationLabel.layer.cornerRadius = 0
                durationLabel.clipsToBounds = false;
                baseSlider.thumbTintColor = AppColors.Primary;
                baseSlider.alpha = 1
                baseSlider.isEnabled = true;
            } else {
                durationLabel.text = " LIVE "
                isLive = true;
                durationLabel.backgroundColor = .systemRed;
                durationLabel.layer.cornerRadius = durationLabel.frame.width / 8;
                durationLabel.clipsToBounds = true;
                baseSlider.thumbTintColor = .systemRed;
                baseSlider.alpha = 0.2
                baseSlider.isEnabled = false;
            }
        }
    }
    
    var currentTime: Double = 0 {
        didSet {
            if (!beginSeeking) {
                baseSlider.value = Float(currentTime);
                currentTimeLabel.text = AppUtility.secondsToHMS(currentTime)
            }
        }
    }
    
    var seekRanges: [NSValue] = [] {
        didSet {
            updateSeekableFragsUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 400, height: 16)
    }
}

extension PlayerProgressBarView {
    
    func setup(){
        baseSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        baseSlider.addTarget(self, action: #selector(sliderTouchUp), for: .touchUpInside)
        baseSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        baseSlider.translatesAutoresizingMaskIntoConstraints = false;
        baseSlider.tintColor = AppColors.Primary;
        baseSlider.thumbTintColor = AppColors.Primary;
        
        seekView.translatesAutoresizingMaskIntoConstraints = false;
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false;
        durationLabel.textAlignment = .center
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout() {
        addSubview(seekView);
        addSubview(baseSlider);
        addSubview(durationLabel);
        addSubview(currentTimeLabel);
        
        NSLayoutConstraint.activate([
            baseSlider.topAnchor.constraint(equalTo: topAnchor),
            baseSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            seekView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seekView.trailingAnchor.constraint(equalTo: trailingAnchor),
            seekView.centerYAnchor.constraint(equalTo: centerYAnchor),
            seekView.heightAnchor.constraint(equalToConstant: 4),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: durationLabel.trailingAnchor, multiplier: 0),
            durationLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//            durationLabel.widthAnchor.constraint(equalToConstant: 128),
            
            currentTimeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
            currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//            currentTimeLabel.widthAnchor.constraint(equalToConstant: 128),
        ])
    }
    
    func updateSeekableFragsUI() {
        seekView.subviews.forEach({$0.removeFromSuperview()})
        if (!isLive) {
            for range in seekRanges.makeIterator() {
                let start = range.timeRangeValue.start.seconds;
                let end = range.timeRangeValue.end.seconds;
                
                let rangeFrag = UIView();
                let rangeFrame = CGRect(x: layer.frame.width * (start / Double(duration)),
                                        y: 1,
                                        width: layer.frame.width * (end - start) / duration,
                                        height: 4);
                rangeFrag.layer.cornerRadius = 2;
                rangeFrag.clipsToBounds = true;
                rangeFrag.frame = rangeFrame;
                rangeFrag.backgroundColor = AppColors.PlayerBufferRange;
                seekView.addSubview(rangeFrag);
            }
        }
        
    }
    
}

// MARK: - Actions
extension PlayerProgressBarView {
    @objc func sliderTouchUp(_ sender: UISlider){
        let time = CMTime(seconds: Double(baseSlider.value), preferredTimescale: 60000)
        delegate?.progressBarSeek(time, sender: self)
        beginSeeking = false;

    }
    
    @objc func sliderTouchDown(_ sender: UISlider){
        beginSeeking = true;
    }
    
    @objc func sliderValueChanged(_ sender: UISlider){
        currentTimeLabel.text = AppUtility.secondsToHMS(baseSlider.value)
    }
}
