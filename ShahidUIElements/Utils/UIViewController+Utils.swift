//
//  UIViewController+Utils.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import UIKit;

// MARK: - UIViewController implementation

extension UIViewController {

    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
