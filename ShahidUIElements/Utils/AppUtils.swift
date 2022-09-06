//
//  AppUtils.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//

import UIKit;

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
   
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

    
    static func secondsToHMS<T: BinaryFloatingPoint>(_ seconds: T) -> String {
        let full = Int(seconds);
        let h = Int(full / 3600);
        let m = Int((full % 3600) / 60);
        let s = Int((full % 3600) % 60);
        if (h == 0) {
            return String(format: "%02d:%02d", m, s)
        }
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}
