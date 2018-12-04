//
//  APIManagerTests.swift
//  ImageFinderTests
//
//  Created by Andrea Altea on 04/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import XCTest
@testable import ImageFinder

class APIManagerTests: XCTestCase {

    var session : MockURLSession!
    var manager: APIManager!
    
    override func setUp() {
     
        self.session = MockURLSession()
        self.manager = APIManager(configuration: APIManager.Configuration(baseURL: URLComponents(string: "https://api.unsplash.com/")!,
                                                                          session: self.session,
                                                                          accessKey: "test_key"))
    }

    override func tearDown() {
        
        self.session = nil
        self.manager = nil
    }

    func testSearchRequest() {
        
        let queryString = "testWord"
        
        self.session.requestCheckBlock = { request in
            
            guard let url = request.url?.absoluteString else {
                XCTFail("Invalid url")
                return
            }
            
            XCTAssert(request.url?.path == "/search/photos")
            XCTAssert(request.url?.query == "client_id=test_key&query=\(queryString)&page=1")
        }
        self.manager.getImages(for: queryString, page: 1) { (result) in
            
        }
    }

    func testFullImageRequest() {
        
        let imageId = "testId"
        
        self.session.requestCheckBlock = { request in
            
            guard let url = request.url?.absoluteString else {
                XCTFail("Invalid url")
                return
            }
            
            XCTAssert(request.url?.path == "/photos/\(imageId)")
            XCTAssert(request.url?.query == "client_id=test_key")
        }
        self.manager.getImage(imageId) { (result) in

        }
    }

    
}

class MockURLSession: URLSession {
    
    var requestCheckBlock: ((_ request: URLRequest) -> Void)?
    
    var responseConfig: (data: Data?, response: HTTPURLResponse?, error: Error?)?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if let requestCheckBlock = self.requestCheckBlock {
            requestCheckBlock(request)
        }
        
        return MockSessionDataTask(config: self.responseConfig, completionHandler: completionHandler)
    }
}

class MockSessionDataTask: URLSessionDataTask {
    
    enum DataError: Error {
        
        case notConfigured
    }
    
    var config: (data: Data?, response: HTTPURLResponse?, error: Error?)?
    
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    init(config: (data: Data?, response: HTTPURLResponse?, error: Error?)?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        self.config = config
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        
        guard let config = self.config else {
            
            completionHandler(nil, nil, DataError.notConfigured)
            return
        }
        completionHandler(config.data, config.response, config.error)
    }
}

