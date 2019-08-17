//
//  Information.swift
//  AxxessChallenge
//
//  Created by Balaji Peddaiahgari on 8/15/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Type: String, Comparable {
    case text = "text"
    case image = "image"
    case other = "other"
    case unknown
    
    static func < (lhs: Type, rhs: Type) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// Model based on the JSON fields
class Information {
    var id: String
    var type: Type
    var date: String
    var data: String?
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.type = Type(rawValue: json["type"].stringValue) ?? .unknown
        self.data = json["data"].stringValue
        self.date = json["date"].stringValue
    }
}
