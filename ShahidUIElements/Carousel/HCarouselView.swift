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
    
    var items: [Channel] = [] {
        didSet {
            tableView.reloadData();
        }
    }
    
    var onChannelTouch: ((_: Channel)->Void)?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.register(HCardCell.self, forCellReuseIdentifier: K.HCardCellId)
        
        style(); // @TODO:
        layout(); // @TODO:
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
}

extension HCarouselView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.transform = CGAffineTransform(rotationAngle: -1.57079632679);
        tableView.backgroundColor = AppColors.BoxBackground
        tableView.sectionHeaderHeight = 0;
        tableView.separatorColor = .clear
    }
    
    func layout() {
        addSubview(tableView);
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: heightAnchor),
            tableView.heightAnchor.constraint(equalTo: widthAnchor),
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
            onChannelTouch(items[indexPath.row])
        }
    }

}

// MARK: - UITableViewDataSource
extension HCarouselView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.HCardCellId, for: indexPath) as! HCardCell;
        let channel = items[indexPath.row]
        cell.title = channel.title;
        cell.imageUrl = channel.logo ?? "https://cdn-icons-png.flaticon.com/512/295/295489.png";
        
        return cell;
    }
        
}
