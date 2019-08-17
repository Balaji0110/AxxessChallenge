//
//  NetworkManager.swift
//  AxxessChallenge
//
//  Created by Balaji Peddaiahgari on 8/15/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// use for make an api call using Alamofire and get the data
class NetworkManager {
    private static let endpoint = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    static func getJSONData(completion: @escaping ([Information]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let data):
                let JSONDataArray = JSON(data).arrayValue
                var informationArray = [Information]()
                for information in JSONDataArray {
                    let newInformation = Information(json: information)
                    informationArray.append(newInformation)
                }
                completion(informationArray)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

