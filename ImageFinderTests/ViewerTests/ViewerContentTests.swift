//
//  ViewerContentTests.swift
//  ImageFinderTests
//
//  Created by Andrea Altea on 05/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import XCTest
@testable import ImageFinder

class ViewerContentTests: XCTestCase {

    var image: Image!
    var fullImage: FullImage!
    
    override func setUp() {
        
        self.image = ImageMock.image
        self.fullImage = ImageMock.fullImage
    }

    override func tearDown() {

        self.image = nil
        self.fullImage = nil
    }
    
    func testCompleteImageContent() {
        
        let content: ViewerContent = ImageViewerContent(image: self.image, fullImage: self.fullImage)
        XCTAssert(content.imageRatio == CGFloat(self.image.ratio))
        XCTAssert(content.lowResPath == self.fullImage.urls.small)
        XCTAssert(content.midResPath == self.fullImage.urls.regular)
        XCTAssert(content.highResPath == self.fullImage.urls.full)
        XCTAssert(content.downloads == String(self.fullImage.downloads))
        XCTAssert(content.likes == String(self.image.likes))
    }
    
    func testFailedLoadImageContent() {
        
        let content: ViewerContent = ImageViewerContent(image: self.image, fullImage: nil)
        XCTAssert(content.imageRatio == CGFloat(self.image.ratio))
        XCTAssert(content.lowResPath == self.image.links.download)
        XCTAssert(content.midResPath == self.image.links.download)
        XCTAssert(content.highResPath == self.image.links.download)
        XCTAssert(content.downloads == "--")
        XCTAssert(content.likes == String(self.image.likes))
    }
}
