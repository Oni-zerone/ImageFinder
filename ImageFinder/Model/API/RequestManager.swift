//
//  RequestManager.swift
//  ImageFinder
//
//  Created by Andrea Altea on 29/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    
    case invalidURL = "Invalid URL"
    case unknownError = "Unknown Error"
    case rateLimitExceded = "API rate limit exceded"
    
    var localizedDescription: String {
        return self.rawValue
    }
}

class APIManager {
    
    enum Result<Value> {
        
        case success(value: Value)
        case failure(Error)
    }
    
    static var standard = APIManager(configuration: .mock)
    
    var configuration: Configuration
    
    init(configuration: Configuration) {
        
        self.configuration = configuration
    }
}

extension APIManager {
    
    func getImages(for query: String, page: Int = 1, completion: @escaping (_ result: Result<SearchResult>) -> Void) {
        
        let path = "/search/photos"
        let search = URLQueryItem(name: "query", value: query)
        let page = URLQueryItem(name: "page", value: String(page))
        
        self.getResource(path, queryItems: [search, page], completion: completion)
    }
    
    func getImage(_ id: String, queue: DispatchQueue = .main, completion: @escaping (_ result: Result<FullImage>) -> Void) {
        
        let path = "/photos/" + id
        self.getResource(path, completion: completion)
    }
}

protocol Parsable: Codable {
    
    static func parse(from data: Data) throws -> Self
}

extension Parsable {
    
    static func parse(from data: Data) throws -> Self {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }
}

extension APIManager {
    
    func getResource<Resource: Parsable>(_ path: String, queryItems: [URLQueryItem] = [], completion: @escaping (_ result: Result<Resource>) -> Void) {
        
        guard let url = self.configuration.makeURL(from: path, queryItems: queryItems) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let request = self.configuration.makeRequest(for: url)
        self.configuration.session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 403 {
                completion(.failure(APIError.rateLimitExceded))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.unknownError))
                return
            }
            
            do {
                
                let result = try Resource.parse(from: data)
                completion(.success(value: result))
                
            } catch let error {
                completion(.failure(error))
            }
            }.resume()
    }
}
