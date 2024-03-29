//
//  DataStepTests.swift
//  ImageFinderTests
//
//  Created by Andrea Altea on 04/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import XCTest
@testable import ImageFinder

class DataStepTests: XCTestCase {

    var provider = APIManager(configuration: .mock)
    var pipeline: Pipeline!
    
    override func setUp() {
        
        self.pipeline = Pipeline()
    }

    override func tearDown() {
        
        self.pipeline = nil
    }

    func testImageLoad() {
        
        let expect = expectation(description: "testImageLoad_viewModel")
        
        let imageLoader = ImageLoadStep()
        imageLoader.provider = self.provider
        self.pipeline.append(imageLoader)

        self.pipeline.append(DataStep())
        
        let dummy = DummyDataStep()
        self.pipeline.append(dummy)
        dummy.successBlock = { model in
            
            defer { expect.fulfill() }
            
            guard let firstSection = model.first as? UnsplashSectionViewModel else {
                XCTFail("Invalid section")
                return
            }
            
            XCTAssert(firstSection.unsplashItems.count == 10)
            firstSection.unsplashItems.forEach({ (imageModel) in
                XCTAssert(imageModel.fullImage == nil)
            })
        }
        imageLoader.queryString = "test_string"
        wait(for: [expect], timeout: 10)
    }
    
    func testEmptySearch() {
        
        let expect = expectation(description: "testEmptySearch_viewModel")
        
        let imageLoader = ImageLoadStep()
        imageLoader.provider = self.provider
        self.pipeline.append(imageLoader)
        
        self.pipeline.append(DataStep())
        
        let dummy = DummyDataStep()
        self.pipeline.append(dummy)
        dummy.failureBlock = { error in

            defer { expect.fulfill() }

            XCTAssert(ImageLoadErrors.noContent == (error as? ImageLoadErrors))
        }
        imageLoader.queryString = "empty"
        wait(for: [expect], timeout: 10)
    }
    
    func testFullImageLoad() {
        
        let expect = expectation(description: "testFullImageLoad_viewModel")
        
        let imageLoader = ImageLoadStep()
        imageLoader.provider = self.provider
        self.pipeline.append(imageLoader)

        let fullImageLoader = FullImageLoaderStep()
        fullImageLoader.provider = self.provider
        self.pipeline.append(fullImageLoader)
        
        let dummy = DummyDataStep()
        self.pipeline.append(dummy)
        dummy.successBlock = { model in
            
            defer { expect.fulfill() }

            guard let firstSection = model.first as? UnsplashSectionViewModel else {
                XCTFail("Invalid section")
                return
            }

            XCTAssert(firstSection.unsplashItems.count == 10)
            firstSection.unsplashItems.forEach({ (imageModel) in
                XCTAssert(imageModel.fullImage != nil)
            })
        }
        
        imageLoader.queryString = "test_string"
        wait(for: [expect], timeout: 20)
    }
    
    func testImageLoadSecondPage() {
        
        var page: Int = 1

        let expect = expectation(description: "testImageLoadSecondPage_viewModel")
        expect.expectedFulfillmentCount = 2
        
        let imageLoader = ImageLoadStep()
        imageLoader.provider = self.provider
        self.pipeline.append(imageLoader)
        
        let dummy = DummyDataStep()
        self.pipeline.append(dummy)
        dummy.successBlock = { model in
            
            defer { expect.fulfill() }
            
            guard let firstSection = model.first as? UnsplashSectionViewModel else {
                XCTFail("Invalid section")
                return
            }
            
            XCTAssert(firstSection.unsplashItems.count == 10 * page)
            firstSection.unsplashItems.forEach({ (imageModel) in
                XCTAssert(imageModel.fullImage == nil)
            })
            page += 1
        }
        
        imageLoader.queryString = "test_string"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            imageLoader.loadImages()
        }
        
        wait(for: [expect], timeout: 10)
    }
    
    func testFailureMessageDataStep() {
        
        let error = APIError.invalidURL
        let expect = expectation(description: "testEmptySearch_viewModel")
        
        let messageStep = FailureMessageDataStep()
        self.pipeline.append(messageStep)
        
        let dummy = DummyDataStep()
        self.pipeline.append(dummy)
        dummy.failureBlock = { error in
            XCTFail()
        }
        dummy.successBlock = { model in
            
            defer { expect.fulfill() }
            
            guard let section = model.first as? MessageSectionViewModel else {
                XCTFail()
                return
            }
            
            XCTAssert(section.items.count == 1)
            guard let item = section.items.first as? MessageViewModel else {
                XCTFail()
                return
            }
            XCTAssert(item.message == error.message)
        }
        messageStep.failed(with: error)
        wait(for: [expect], timeout: 10)
    }
}

class DummyDataStep: DataStep {
    
    var successBlock: ((CollectionModel) -> Void)?
    var failureBlock: ((Error) -> Void)?
    
    override func success(with model: CollectionModel) {
        self.successBlock?(model)
    }
    
    override func failed(with error: Error) {
        self.failureBlock?(error)
    }
}
