//
//  Option.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Option {
    let id: Int64?
    let productId: Int64?
    let name: String?
    let position: Int?
    let values: [String]?
}

extension Option: JSONMappable {
    static func fromJSON(_ json: Any) -> Option {
        let json = JSON(json)
        
        let id = json["id"].int64Value
        let productId = json["product_id"].int64Value
        let name = json["name"].stringValue
        let position = json["position"].intValue
        let values = json["values"].arrayObject as? [String]
        
        return Option(id: id,
                      productId: productId,
                      name: name,
                      position: position,
                      values: values)
    }
}

