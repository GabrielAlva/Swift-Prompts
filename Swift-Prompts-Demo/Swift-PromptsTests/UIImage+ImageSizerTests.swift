//
//  UIImage+ImageSizerTests.swift
//  Swift-Prompts
//
//  Created by Marc Stroebel on 2015/11/19.
//  Copyright © 2015 Gabriel Alvarado. All rights reserved.
//

import UIKit
import XCTest
@testable import Swift_Prompts

class UIImage_ImageSizerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSizingOfImageThatHasWidthAndHeightTooLarge() {
        let imageToTest = UIImage(named: "test-image-3")
        let maximumWidth = 200 as CGFloat
        let maximumHeight = 200 as CGFloat
        
        let calculatedSize = imageToTest!.calculateImageSizeForConstraints(maximumWidth, maximumHeight: maximumHeight)
        
        XCTAssert(calculatedSize.width <= maximumWidth, "Image resizing failed; Width too large")
        XCTAssert(calculatedSize.height <= maximumHeight, "Image resizing failed; Height too large")
    }
    
}
