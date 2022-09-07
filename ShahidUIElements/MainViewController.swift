//
//  MainViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 27/08/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let carouselCtrl = CarouselViewController();
    
    let backgroundImage = UIImageView();
    
    let stackView = UIStackView();
    let label = UILabel();
    
    let buttonRotate = ButtonView(type: .primary);
    let channelsButton = ButtonView(type: .secondary);
    let box = BoxView();
    let inputText = TextInputView();
    
    let swipeUpLabel = UILabel();
    let boxBackgroundImage = UIImageView();
    
    var didBoxSwiped = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setup();
        style();
        layout();
    }
    
}

extension MainViewController {
    func setup(){
        buttonRotate.addTarget(self, action: #selector(rotateButton), for: .touchUpInside)
        channelsButton.addTarget(self, action: #selector(goToChannels), for: .touchUpInside)
        
        box.isUserInteractionEnabled = true;
        let swipeUpGesture = UIPanGestureRecognizer(target: self, action: #selector(boxSwiped))
        box.addGestureRecognizer(swipeUpGesture);
        
        backgroundImage.fetchRemote(url: "https://images.squarespace-cdn.com/content/v1/5e949a92e17d55230cd1d44f/1636123984810-E1VU52Y79R03T8X8JDOE/RainbowAppleIDiPAd.png");
        backgroundImage.clipsToBounds = true;
        boxBackgroundImage.fetchRemote(url: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MMMP3_AV1?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1645136903902")
    }
    
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "TEXT LABEL TODO";
        label.font = UIFont.preferredFont(forTextStyle: .title1);
        
        box.translatesAutoresizingMaskIntoConstraints = false;
        box.addBlurEffect(style: .light);
        buttonRotate.translatesAutoresizingMaskIntoConstraints = false;
        buttonRotate.label = "Press To Rotate";
        buttonRotate.setImage(.init(systemName: "cloud"), for: []);
        
        channelsButton.translatesAutoresizingMaskIntoConstraints = false;
        channelsButton.label = "Go To Channels";
        
        inputText.translatesAutoresizingMaskIntoConstraints = false;
        inputText.placeholder = "Placeholder"
        
        // box elms
        swipeUpLabel.translatesAutoresizingMaskIntoConstraints = false;
        swipeUpLabel.textAlignment = .center;
        swipeUpLabel.text = "Swipe up to open channels";
        
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false;
        backgroundImage.contentMode = .scaleAspectFill
        
        
        boxBackgroundImage.translatesAutoresizingMaskIntoConstraints = false;
        boxBackgroundImage.contentMode = .scaleAspectFill
        
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label);
        stackView.addArrangedSubview(inputText);
        stackView.addArrangedSubview(channelsButton);
        
        stackView.addArrangedSubview(buttonRotate);
        stackView.addArrangedSubview(box);
        
        //        box.addSubview(boxBackgroundImage);
        box.addSubview(swipeUpLabel);
        
        view.addSubview(backgroundImage);
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            box.heightAnchor.constraint(equalToConstant: 64*2),
            
            // box elms
            swipeUpLabel.topAnchor.constraint(equalTo: box.topAnchor),
            swipeUpLabel.leadingAnchor.constraint(equalTo: box.leadingAnchor),
            swipeUpLabel.bottomAnchor.constraint(equalTo: box.bottomAnchor),
            swipeUpLabel.trailingAnchor.constraint(equalTo: box.trailingAnchor),
            
            //            boxBackgroundImage.topAnchor.constraint(equalTo: box.topAnchor),
            //            boxBackgroundImage.leadingAnchor.constraint(equalTo: box.leadingAnchor),
            //            boxBackgroundImage.bottomAnchor.constraint(equalTo: box.bottomAnchor),
            //            boxBackgroundImage.trailingAnchor.constraint(equalTo: box.trailingAnchor),
        ])
    }
}


// MARK: - Actions
extension MainViewController {
    @objc func rotateButton(_ sender: ButtonView) {
        inputText.disabled = !inputText.disabled;
        switch sender.type {
        case .disabled: sender.type = .secondary;
        case .secondary: sender.type = .primary;
        case .primary: sender.type = .normal;
        case .normal: sender.type = .disabled;
            
        }
    }
    
    
    @objc func goToChannels(_ sender: ButtonView) {
        self.navigationController?.pushViewController(carouselCtrl, animated: true)
    }
    
    
    @objc func boxSwiped(_ gesture: UIPanGestureRecognizer){
        if didBoxSwiped { return };
        if gesture.velocity(in: box).y < -1300 {
            didBoxSwiped = true;
            carouselCtrl.modalTransitionStyle = .coverVertical;
            carouselCtrl.modalPresentationStyle = .pageSheet;
            if let presentationController = carouselCtrl.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(), .large(),]
            }
            
            present(carouselCtrl, animated: true) {
                self.didBoxSwiped = false
            };
        }
        
        //        let translation = gesture.translation(in: box);
        //        let x = gesture.view?.center.x;
        //        let y = gesture.view?.center.y;
        //
        //        if(translation.x <= 20 && translation.y <= 20 )
        //        {
        //            gesture.view?.center=CGPoint(x: x!+translation.x, y: y!+translation.y)
        //
        //            UIView.animate(withDuration: 1000, delay: 0) {
        //                gesture.setTranslation(CGPoint.zero, in: self.view)
        //            }
        //        }
    }
}
