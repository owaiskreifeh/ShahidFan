//
//  AppDelegate.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 27/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var orientationLock = UIInterfaceOrientationMask.all

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible();
        window?.backgroundColor = .systemBackground;
//        window?.rootViewController = MainViewController();
//        window?.rootViewController = CarouselViewController();
//        window?.rootViewController = PlayerViewController();
        
        window?.rootViewController = UINavigationController(rootViewController: ReactiveViewController());

        
        return true;
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }

}

