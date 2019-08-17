//
//  ViewController.swift
//  AxxessChallenge
//
//  Created by Balaji Peddaiahgari on 8/15/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var differentTypes:[Type] = []
    
    internal var informationArray: [Information] = [] {
        didSet {
            differentTypes = Array(Set(informationArray.map {$0.type})).sorted(by: <) //This extract the unique elements from the array and sort the elements
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Types"
        tableView.register(TypeCell.self, forCellReuseIdentifier: "reuseIdentifier") //Registering TableView Cell
        getJsonData()
    }
    
    //Make a network call and get the necessary data
    func getJsonData() {
        NetworkManager.getJSONData { informationArray in
            self.informationArray = informationArray
        }
    }
    
    //TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return differentTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TypeCell
        cell.textLabel?.text = differentTypes[indexPath.row].rawValue.capitalized
        return cell
    }
    
    //TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listTypeArray = informationArray.filter{$0.type == differentTypes[indexPath.row] && $0.data != ""} //Passing the specific type elements to the list view controller
        let listViewController = ListViewController()
        listViewController.specificTypeArray = listTypeArray
        self.navigationController?.pushViewController(listViewController, animated: true)
    }

}
