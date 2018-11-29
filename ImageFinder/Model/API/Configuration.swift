//
//  Configuration.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

extension APIManager {
    
    struct Configuration {
        
        typealias ApplicationKey = (clientId: String, secret: String)

        let baseURL: URLComponents
        
        let session: URLSession
        
        let accessKey: String

        func makeURL(from path: String, queryItems: [URLQueryItem]) -> URL? {
            
            var builder = self.baseURL
            builder.path = path
            builder.queryItems = [URLQueryItem(name: "client_id", value: self.accessKey)] + queryItems
            return builder.url
        }
        
        func makeRequest(for url: URL) -> URLRequest {
            
                var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
                request.allHTTPHeaderFields = [:]
                request.allHTTPHeaderFields?["Accept"]  = "application/json"
                request.allHTTPHeaderFields?["Accept-Version"] = "v1"
            
                return request
        }
        
        static let production = Configuration(baseURL: URLComponents(string: "https://api.unsplash.com/")!,
                                              session: URLSession(configuration: .default),
                                              accessKey: "8d67aff4fa2d17d5cc26bd254bdff216d108d21a46a40055bcab8d79e1e6e3dd")
    }
}
