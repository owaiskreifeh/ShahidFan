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

func fetchCarousel(_ completion: @escaping (Result<[Channel], NetworkError>) -> Void) {
    let path = "https://raw.githubusercontent.com/owaiskreifeh/jsons_snippets/main/vod-hls.json"
    if let url = URL(string: path) {
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
