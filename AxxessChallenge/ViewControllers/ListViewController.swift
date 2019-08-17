//
//  ListViewController.swift
//  AxxessChallenge
//
//  Created by Balaji Peddaiahgari on 8/15/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, UIImage>() // using for Caching the images

class ListViewController: UITableViewController {
    var specificTypeArray:[Information] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "List"
        tableView.register(TypeCell.self, forCellReuseIdentifier: "ListReuseIdentifier")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificTypeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListReuseIdentifier", for: indexPath) as! TypeCell
        cell.setup(with: specificTypeArray[indexPath.row])
        //Placing the image in cell ImageView
        if specificTypeArray[indexPath.row].type == .image {
            guard let url = URL(string: specificTypeArray[indexPath.row].data!) else {
                cell.imageView?.image = UIImage(named: "no-image")
                return cell
            }
            cell.imageView?.load(url: url) {
                cell.setNeedsUpdateConstraints()
            }
            return cell
        }
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedVC()
        detailedVC.type = specificTypeArray[indexPath.row].type
        detailedVC.data = specificTypeArray[indexPath.row].data! //Passing the specific type data to the Detailed view controller
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension UIImageView {
    //Load the image from url and displays in it
    func load(url: URL, completion: (()->Void)?) {
        func loadNoImage() {
            DispatchQueue.main.async {
                self.image = UIImage(named: "no-image.png")
                completion?()
            }
        }
        //Extracts the image from the cache
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = image
            completion?()
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString) //If image exists, cache it.
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?()
                    }
                } else {
                    loadNoImage()
                }
            }
        }
    }
}

