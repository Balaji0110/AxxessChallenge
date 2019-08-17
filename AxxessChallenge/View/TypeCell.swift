//
//  TypeCell.swift
//  AxxessChallenge
//
//  Created by Balaji Peddaiahgari on 8/16/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import UIKit

class TypeCell: UITableViewCell {
    var idLabel: UILabel = UILabel() //Displays ID
    var dateLabel: UILabel = UILabel() //Displays Date
    var dataLabel:UILabel = UILabel() //Displays Data
    var type: Type = .unknown
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setting the constraints for each Label
    override func updateConstraints() {
        
        self.contentView.addSubview(idLabel)
        idLabel.textColor = .gray
        idLabel.textAlignment = NSTextAlignment.left
        idLabel.font = UIFont.boldSystemFont(ofSize: 10)
        idLabel.snp.makeConstraints { make in
            if let imageView = self.imageView, imageView.image != nil {
                make.leading.equalTo(imageView.snp.trailing).offset(4)
            } else {
                make.leading.equalToSuperview().offset(8)
            }
            make.top.equalToSuperview().offset(8)
        }
        
        self.contentView.addSubview(dateLabel)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.boldSystemFont(ofSize: 10)
        dateLabel.snp.makeConstraints { make in
            make.top.height.equalTo(idLabel)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        //When the type is not equal to image, displays the Data otherwise no need of displaying URL when the type is image
        if type != .image {
            self.contentView.addSubview(dataLabel)
            dataLabel.textColor = .black
            dataLabel.font = UIFont.boldSystemFont(ofSize: 14)
            dataLabel.snp.makeConstraints { make in
                make.top.equalTo(idLabel.snp.bottom).offset(4)
                make.leading.equalTo(idLabel)
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(-4)
            }
        }
        super.updateConstraints()
    }
    
    //Providing the specific information to the cell
    func setup(with information: Information) {
        idLabel.text = "Id: " + information.id
        dateLabel.text = information.date
        dataLabel.text = startWithLetters(input: information.data!)
        type = information.type
    }
    
    //This function useful for displaying the text starts with letters and ignore all other special characters
    private func startWithLetters( input: String) -> String {
        var temporaryString = input
        for chr in input {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                temporaryString.remove(at: temporaryString.startIndex)
                continue
            }
            return temporaryString
        }
        return input
    }
    
}
