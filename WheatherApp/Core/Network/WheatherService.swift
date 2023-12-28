//
//  WheatherService.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import Foundation

enum WheatherServiceError: Error {
    case invalidResponse
}

actor WheatherService {
    
    func fetchData<T: Decodable>(api: ApiConstructor, _ cityName: String) async throws -> T {
        
        let url = try DefaultURLBuilder.build(api: api, cityName)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw WheatherServiceError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
