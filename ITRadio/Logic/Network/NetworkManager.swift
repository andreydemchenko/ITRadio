//
//  NetworkManager.swift
//  ITRadio
//
//  Created by zuzex-62 on 18.01.2023.
//

import Foundation

protocol NetworkProtocol {
    func getTracks(type: StreamType, completion: @escaping (Result<TrackResponse, Error>) -> Void)
}

class NetworkManager: NetworkProtocol {
    
    let urlError = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Invalid url"])
    
    func getTracks(type: StreamType, completion: @escaping (Result<TrackResponse, Error>) -> Void) {
        let url = URL(string: "https://rock.it-radio.ru/api/track/current?type=\(type.streamTypeUrl)")
        guard let requestUrl = url else { return completion(.failure(urlError)) }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        query(request: request, modelType: TrackResponse.self) { res in
            switch res {
            case let .success(model):
                completion(.success(model))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        
    }
    
    private func query<T: Codable>(request: URLRequest, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error.localizedDescription)")
                return completion(.failure(error))
            }
            
            if let data {
                do {
                    let responseModel = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseModel))
                } catch let error {
                    completion(.failure(error))
                }
            }
            else if let response {
                let error = NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "Response error: \(response)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
}
