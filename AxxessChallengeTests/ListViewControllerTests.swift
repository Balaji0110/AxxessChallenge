//
//  ListViewControllerTests.swift
//  AxxessChallengeTests
//
//  Created by Balaji Peddaiahgari on 8/17/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import AxxessChallenge

class ListViewControllerTests: XCTestCase {
    var viewController: ListViewController!
    var specificTypeArray: [Information] = []
    
    override func setUp() {
        viewController = ListViewController()
        if let imageTypeInformation = getImageTypeInformation(),
            let textTypeInformation = getTextTypeInformation() {
            specificTypeArray.append(contentsOf: [imageTypeInformation, textTypeInformation])
        }
        viewController.specificTypeArray = specificTypeArray
    }
    
    func testTableViewDataSource() {
        XCTAssertEqual(2, viewController.tableView.numberOfRows(inSection: 0))
    }
    
    func testTableViewCellReuseIdentifier() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as UITableViewCell
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "ListReuseIdentifier"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableViewCellTextLabel() {
        let cell0 = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TypeCell
        XCTAssertEqual(cell0.idLabel.text, "Id: 1151")
        XCTAssertEqual(cell0.dateLabel.text, "02/5/2017")
        let cell1 = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as! TypeCell
        XCTAssertEqual(cell1.idLabel.text, "Id: 1290")
        XCTAssertEqual(cell1.dateLabel.text, "10/10/2010")
        XCTAssertEqual(cell1.dataLabel.text, "This is another short string")
    }
    
    func getTextTypeInformation() -> Information? {
        let informationData = [
            "id": "1290",
            "type": "text",
            "date": "10/10/2010",
            "data": "This is another short string"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: informationData, options: .prettyPrinted)
        if let jsonData = jsonData {
            guard let json = try? JSON(data: jsonData, options: .allowFragments) else { return nil }
            return Information(json: json)
        }
        return nil
    }
    
    func getImageTypeInformation() -> Information? {
        let informationData = [
            "id": "1151",
            "type": "image",
            "date": "02/5/2017",
            "data": "https://placeimg.com/320/320/any"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: informationData, options: .prettyPrinted)
        if let jsonData = jsonData {
            guard let json = try? JSON(data: jsonData, options: .allowFragments) else { return nil }
            return Information(json: json)
        }
        return nil
    }
}
