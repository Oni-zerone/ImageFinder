//
//  ImageViewModelTests.swift
//  ImageFinderTests
//
//  Created by Andrea Altea on 05/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import XCTest
@testable import ImageFinder

class ImageViewModelTests: XCTestCase {
    
    let image = ImageMock.image
    let fullImage = ImageMock.fullImage
    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testImageViewModel() {
    
        let imageViewModel = ImageViewModel(image: self.image, fullImage: nil)
        
        XCTAssert(imageViewModel.multiplier == CGFloat(self.image.ratio))
        
        guard let resource = imageViewModel.imageLoader else {
            XCTFail()
            return
        }
        XCTAssert(resource.downloadURL.absoluteString == self.image.links.download)
    }
    
    func testFullImageViewModel() {
     
        let imageViewModel = ImageViewModel(image: self.image, fullImage: self.fullImage)
        
        XCTAssert(imageViewModel.multiplier == CGFloat(self.image.ratio))
        
        guard let resource = imageViewModel.imageLoader else {
            XCTFail()
            return
        }
        XCTAssert(resource.downloadURL.absoluteString == self.fullImage.urls.thumb)
    }
}
