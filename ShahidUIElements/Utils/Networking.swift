//
//  Networking.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 06/09/2022.
//

import Foundation

enum NetworkError: Error {
    case serverError, decodeError;
}

func fetchCarousel(_ fromUrl: String, completion: @escaping (Result<[Channel], NetworkError>) -> Void) {
    if let url = URL(string: fromUrl) {
        let session = URLSession(configuration: .default);
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                // check for errors, and unwrap data
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                // json decode
                let decoder = JSONDecoder();

                do {
                    let channels = try decoder.decode([Channel].self, from: data);
                    completion(.success(channels))
                } catch{
                    completion(.failure(.decodeError))
                }
            }
            
        };
        task.resume();
    }
}
