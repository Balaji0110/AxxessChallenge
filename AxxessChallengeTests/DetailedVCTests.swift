//
//  DetailedVCTests.swift
//  AxxessChallengeTests
//
//  Created by Balaji Peddaiahgari on 8/17/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import XCTest
@testable import AxxessChallenge

class DetailedVCTests: XCTestCase {
    var viewController: DetailedVC!
    
    override func setUp() {
        viewController = DetailedVC()
    }
    
    func testLabelConstraints() {
        viewController.type = .text
        viewController.data = "This is another short string"
        viewController.addSubViewAndConstraints()
        XCTAssertEqual("This is another short string", viewController.label.text)
        XCTAssertEqual(UIFont.boldSystemFont(ofSize: 16), viewController.label.font)
        XCTAssertNil(viewController.imageView.image)
    }
    func testImageConstriants() {
        viewController.type = .image
        viewController.data = "http://another/bad/url"
        viewController.addSubViewAndConstraints()
        XCTAssertEqual(viewController.imageView.contentMode, UIView.ContentMode.scaleAspectFit)
        XCTAssertNil(viewController.label.text)
    }
}
