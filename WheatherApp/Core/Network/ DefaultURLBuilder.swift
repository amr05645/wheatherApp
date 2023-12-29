//
//   DefaultURLBuilder.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import Foundation

enum DefaultURLBuilderError: Error {
    case invalidPath
    case invalidUrl
}


enum DefaultURLBuilder {
    
    static func build(api: ApiConstructor, _ cityName: String) throws -> URL {
        
        guard var urlComponents = URLComponents(string: api.endPoint.fullPath) else {
            throw DefaultURLBuilderError.invalidPath
        }
        
        urlComponents.queryItems = try  buildQueryParams(api.params, ["key": Constants.apiKey,
                                                                      "q": cityName,
                                                                      "aqi": "no",
                                                                      "days": "5"]
        )
        
        guard let url = urlComponents.url else {
            throw DefaultURLBuilderError.invalidUrl
        }
        
        return url
    }
    
    static func buildQueryParams(_ params: Parameters...) throws -> [URLQueryItem] {
        
        return params.flatMap { $0 }.map({ URLQueryItem(name: $0.key, value: $0.value) })
    }
}
