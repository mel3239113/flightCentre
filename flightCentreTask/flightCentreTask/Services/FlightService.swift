//
//  FlightService.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

protocol FlightSearchService {
    func request<T: Codable>(from endPoint: URL, completionHandler: @escaping (Result<T, Error>) -> Void)
}


struct FlightService: FlightSearchService {
    static let shared = FlightService()
        //i used generics here so this could be used for other expected object types
    func request<T: Codable>(from endPoint: URL, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = URLRequest(url: endPoint)
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(.failure(error))
                }
                if let marshalledItem: T = self.marshalJSON(data: data) {
                    completionHandler(.success(marshalledItem))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "invalid format"])
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
    
    //private method for readability and clarity
    private func marshalJSON<T: Codable>(data: Data?) -> T?  {
        guard let data = data else { return nil }
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            return nil
        }
    }
}


