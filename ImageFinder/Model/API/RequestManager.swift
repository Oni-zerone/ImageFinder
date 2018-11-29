//
//  RequestManager.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case invalidURL
    case unknownError
}

class APIManager {

    enum Result<Value> {
        
        case success(value: Value)
        case failure(Error)
    }
    
    static var standard = APIManager(configuration: .production)
    
    var configuration: Configuration
    
    init(configuration: Configuration) {
        
        self.configuration = configuration
    }
}

extension APIManager {
    
    func getImages(for query: String, page: Int = 1, completion: @escaping (_ result: Result<SearchResult>) -> Void) {
        
        let search = URLQueryItem(name: "query", value: query)
        let page = URLQueryItem(name: "page", value: String(page))
        
        guard let url = self.configuration.makeURL(from: "/search/photos", queryItems: [search, page]) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let request = self.configuration.makeRequest(for: url)
        self.configuration.session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.failure(error ?? APIError.unknownError))
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(SearchResult.self, from: data)
                    completion(.success(value: result))
                    
                } catch let error {
                    completion(.failure(error))
                }
            }
            }.resume()
    }
}
