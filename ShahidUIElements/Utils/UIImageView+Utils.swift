//
//  UIImageView+Utils.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func fetchRemote(url from: String) {
        if let url = URL(string: from) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
    
}
