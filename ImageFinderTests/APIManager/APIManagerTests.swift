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
        let expect = expectation(description: "RequestCheck")
        
        self.session.requestCheckBlock = { request in
            expect.fulfill()
            
            guard let url = request.url else {
                XCTFail("Invalid url")
                return
            }
            XCTAssert(url.path == "/search/photos")
            XCTAssert(url.query == "client_id=test_key&query=\(queryString)&page=1")
            
        }
        self.manager.getImages(for: queryString, page: 1) { (result) in
            
        }
        wait(for: [expect], timeout: 1.0)
    }

    func testSearchRequestSuccess() {
        
        let expect = expectation(description: "Resume")
        
        self.session.responseConfig = (data: DummyDataTask.searchData, response: nil, error: nil)
        self.manager.getImages(for: "", page: 1) { (result) in
            
            switch result  {
                
            case .success(let searchResult):
                XCTAssert(searchResult.results.count == 10)
                
            default:
                XCTFail("invalid response")
            }
            
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1.0)
    }
    
    func testFullImageRequest() {
        
        let imageId = "testId"
        let expect = expectation(description: "RequestCheck")

        self.session.requestCheckBlock = { request in
            expect.fulfill()

            guard let url = request.url else {
                XCTFail("Invalid url")
                return
            }
            XCTAssert(url.path == "/photos/\(imageId)")
            XCTAssert(url.query == "client_id=test_key")
        }
        self.manager.getImage(imageId) { (result) in

        }
        wait(for: [expect], timeout: 1.0)
    }
    
    func testFullImageSuccess() {
        
        let expect = expectation(description: "Resume")
        
        self.session.responseConfig = (data: DummyDataTask.photoData, response: nil, error: nil)
        self.manager.getImage("") { (result) in
            
            switch result  {
                
            case .success(let fullImage):
                XCTAssert(fullImage.id == "8UcNYpynFLU")
                
            default:
                XCTFail("invalid response")
            }
            
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1.0)
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
    
    enum DataError: String, ConvertibleError {
        
        case notConfigured = "Not Configured"
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

