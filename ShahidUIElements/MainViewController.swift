//
//  MainViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 27/08/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let carouselCtrl = CarouselViewController();
    
    let stackView = UIStackView();
    let label = UILabel();
    
    let buttonRotate = ButtonView(type: .primary);
    let channelsButton = ButtonView(type: .secondary);
    let box = BoxView();
    let inputText = TextInputView();
    
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
    }
    
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
                
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "TEXT LABEL TODO";
        label.font = UIFont.preferredFont(forTextStyle: .title1);
        
        box.translatesAutoresizingMaskIntoConstraints = false;
        box.backgroundColor = AppColors.BoxBackground;
        
        buttonRotate.translatesAutoresizingMaskIntoConstraints = false;
        buttonRotate.label = "Press To Rotate";
        buttonRotate.setImage(.init(systemName: "cloud"), for: []);

        channelsButton.translatesAutoresizingMaskIntoConstraints = false;
        channelsButton.label = "Go To Channels";
        
        inputText.translatesAutoresizingMaskIntoConstraints = false;
        inputText.placeholder = "Placeholder"
    }
    
    func layout(){
        stackView.addArrangedSubview(label);
        stackView.addArrangedSubview(inputText);
        stackView.addArrangedSubview(channelsButton);

        stackView.addArrangedSubview(buttonRotate);
        stackView.addArrangedSubview(box);
        
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            box.heightAnchor.constraint(equalToConstant: 64*2),
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
}
