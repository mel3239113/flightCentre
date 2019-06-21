//
//  FlightService.swift
//  flightCentreTask
//
//  Created by Matthew Lewis on 6/22/19.
//  Copyright © 2019 Matthew Lewis. All rights reserved.
//

import Foundation

struct FlightService {
    static let shared = FlightService()
    
    func request<T: Codable>(from endPoint: URL, completionHandler: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: endPoint) {(data, _, error) in
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
    }
    
    
    private func marshalJSON<T: Codable>(data: Data?) -> T?  {
        guard let data = data else { return nil }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            return result
        } catch {
            return nil
        }
    }
}


