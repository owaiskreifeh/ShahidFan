//
//  ReactiveViewController.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 07/09/2022.
//

import UIKit;

class ReactiveViewController: UIViewController {
    
    let stackView = UIStackView();
    let mainVC = MainViewController();
    let btn = ReactiveButton(type: .custom);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
        style();
        layout();
    }
    
}

extension ReactiveViewController {
    
    override func viewDidLayoutSubviews() {
        view.removeGradients()
        view.setGradientBackground(AppColors.GradientColors);

    }
    func style(){
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
    }
    
    func layout(){
        
//        stackView.addArrangedSubview(label);
//        view.addSubview(stackView);
        view.addSubview(btn);

        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}


extension ReactiveViewController {
    @objc func btnTapped(_ sender: ReactiveButton){
        print("here")
        navigationController?.pushViewController(mainVC, animated: true)
    }
}
