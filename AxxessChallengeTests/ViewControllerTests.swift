//
//  AxxessChallengeTests.swift
//  AxxessChallengeTests
//
//  Created by Balaji Peddaiahgari on 8/17/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON
@testable import AxxessChallenge

class ViewControllerTests: XCTestCase {
    var viewController: ViewController!
    var informationArray: [Information] = []

    override func setUp() {
        viewController = ViewController()
        let mockInformationArray = getMockInformationArray()
        viewController.informationArray = mockInformationArray ?? []
    }

    func testTableViewDataSource() {
        XCTAssertEqual(1, viewController.tableView.numberOfRows(inSection: 0))
    }
    
    func testTableViewCellReuseIdentifier() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as UITableViewCell
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "reuseIdentifier"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableViewCellTextLabel() {
        let cell0 = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell0.textLabel!.text, "Image")
    }
    
    func getMockInformationArray() -> [Information]? {
        let informationData = [
            "id": "2639",
            "type": "image",
            "date": "9/4/2015",
            "data": "https://placeimg.com/620/320/any"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: informationData, options: .prettyPrinted)
        if let jsonData = jsonData {
            guard let json = try? JSON(data: jsonData, options: .allowFragments) else { return nil }
            let information = Information(json: json)
            informationArray.append(information)
        }
        return informationArray
    }
}
