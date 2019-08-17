//
//  DetailedVC.swift
//  AxxessChallenge
//
//  Created by Balaji Peddaiahgari on 8/16/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailedVC: UIViewController {
    var type: Type = .unknown
    var data: String = ""
    internal let label = UILabel()
    internal let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Detail"
        addSubViewAndConstraints()
    }
    
    //Adjusting the text or image constraints depends on the type
    func addSubViewAndConstraints() {
        switch type {
        case .text, .other:
            label.text = data
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.textAlignment = .center
            self.view.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(self.view.snp.left).offset(10)
                make.right.equalTo(self.view.snp.right).offset(-10)
                make.top.equalTo(self.view.snp.top).offset(30)
                make.bottom.equalTo(self.view.snp.bottom).offset(-10)
                make.center.equalTo(self.view.center)
            }
        case .image:
            if let url = URL(string: data) {
                imageView.load(url: url, completion: nil)
            }
            imageView.contentMode = .scaleAspectFit
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.height.equalTo(300)
            }
        case .unknown:
            break
        }
    }
}

