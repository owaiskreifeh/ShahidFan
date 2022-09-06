//
//  HCarouselView.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import Foundation
import UIKit

class HCarouselView: UIView {
    
    let tableView = UITableView();
    
    var channels: [Channel] = [];
    
    var onChannelTouch: ((_: Channel)->Void)?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.register(HCardCell.self, forCellReuseIdentifier: K.HCardCellId)
        
        style(); // @TODO:
        layout(); // @TODO:
        
        fetchCarousel { result in
            switch result {
            case .failure(let error):
                print("Error while fetching channels, ", error);
            case .success(let channelsArray):
                self.channels = channelsArray;
                self.tableView.reloadData();
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 200.0)
    }
}

extension HCarouselView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        transform = CGAffineTransform(rotationAngle: -1.57079632679);
        tableView.backgroundColor = AppColors.BoxBackground
        tableView.sectionHeaderHeight = 0;
        tableView.separatorColor = .clear
    }
    
    func layout() {
        addSubview(tableView);
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}


// MARK: - UITableViewDelegate
extension HCarouselView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let onChannelTouch = onChannelTouch {
            onChannelTouch(channels[indexPath.row])
        }
    }

}

// MARK: - UITableViewDataSource
extension HCarouselView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.HCardCellId, for: indexPath) as! HCardCell;
        let channel = channels[indexPath.row]
        cell.title = channel.title;
        cell.imageUrl = channel.logo ?? "https://cdn-icons-png.flaticon.com/512/295/295489.png";
        
        return cell;
    }
        
}
