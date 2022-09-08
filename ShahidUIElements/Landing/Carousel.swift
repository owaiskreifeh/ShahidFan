//
//  CCarousel.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 08/09/2022.
//

import UIKit
import M3UKit

class CarouselView: UIView {
    var title = "Carousel";
    var collectionView: UICollectionView!;
    let numberOfItemsPerView = 3;
    
    var items: [Channel] = [] {
        didSet {
            collectionView.reloadData();
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
        return CGSize(width: 200.0, height: 200.0)
    }
    
}

extension CarouselView {
    
    func setup() {
        
        let layout = UICollectionViewFlowLayout();
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        let nipName = String(describing: CCardViewCell.self);
        let nib = UINib(nibName: nipName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: K.CardCellId)

        layout.scrollDirection = .horizontal
        
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout() {
        addSubview(collectionView);
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    func buildFromPlaylistUrl(_ url: String) {
        if let url = URL(string: url) {
            let playlistParser = PlaylistParser();
            playlistParser.parse(url) { result in
                switch result {
                case .success(let playlist):
                    var channels: [Channel] = [];
                    playlist.medias.forEach { media in
                        let channel = Channel(logo: media.attributes.logo,
                                              title: media.name,
                                              url: media.url.absoluteString)
                        
                        channels.append(channel)
                    }
                    self.items = channels;
                case .failure(let error):
                    print("failed parsing m3u", error)
                }
            }
        }
    }
    
}


// MARK: - UICollectionViewDelegate
extension CarouselView: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension CarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aspectRatio: CGFloat = 145 / 98;
        let currentVisibleSize = collectionView.visibleSize;
        let width = currentVisibleSize.width / CGFloat(numberOfItemsPerView);
        let height = width * aspectRatio;
        return CGSize(width: min(width, currentVisibleSize.width), height: min(height, currentVisibleSize.height));
    }
}

// MARK: - UICollectionViewDataSource
extension CarouselView: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CardCellId, for: indexPath) as! CCardViewCell;
        let channel = items[indexPath.row];
        cell.titleLabel.text = channel.title;
        if let logoUrl = channel.logo {
            cell.logoImageView.fetchRemote(url: logoUrl);
        }
        return cell;
    }
    
    
}
