//
//  LandingViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 08/09/2022.
//

import UIKit;
class LandingViewController: UIViewController {
    let tableView = UITableView();
    
    let numberOfCarouselsInView = 3;
    var carousels: [CarouselView] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setup();
        style();
        layout();
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
    
}

extension LandingViewController {
    
    func setup() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(CarouselCell.self, forCellReuseIdentifier: K.CarouselCellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        [
            "https://iptv-org.github.io/iptv/regions/mena.m3u",
            "https://iptv-org.github.io/iptv/categories/movies.m3u",
            "https://iptv-org.github.io/iptv/categories/music.m3u",
            "https://iptv-org.github.io/iptv/categories/sports.m3u",
            "https://iptv-org.github.io/iptv/categories/documentary.m3u",
        ].forEach { urlString in
            let carousel = CarouselView();
            carousel.buildFromPlaylistUrl(urlString);
            carousel.title = urlString.replacingOccurrences(of: "https://iptv-org.github.io/iptv/", with: "");
            carousels.append(carousel);
        }
    }
    
    
    func style(){
        tableView.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout(){
        view.addSubview(tableView);
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 1),
        ])

    }
}



// MARK: - UITableViewDataSource
extension LandingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / CGFloat(numberOfCarouselsInView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carousels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CarouselCellId, for: indexPath) as! CarouselCell;
        let carousel = carousels[indexPath.row]
        cell.titleLabel.text = carousel.title;
        cell.carousel = carousel;
        return cell;
    }
    
}


// MARK: - UITableViewDelegate
extension LandingViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
