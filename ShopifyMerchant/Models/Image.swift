//
//  Image.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Image {
    let id: Int64?
    let productId: Int64?
    let position: Int?
    let createdAt: String?
    let updatedAt: String?
    let width: Int?
    let height: Int?
    let src: String?
}

extension Image: JSONMappable {
    static func fromJSON(_ json: Any) -> Image {
        let json = JSON(json)
        
        let id = json["id"].int64Value
        let productId = json["product_id"].int64Value
        let position = json["position"].intValue
        let createdAt = json["created_at"].stringValue
        let updatedAt = json["updated_at"].stringValue
        let width = json["width"].intValue
        let height = json["height"].intValue
        let src = json["src"].stringValue
        
        return Image(id: id,
                     productId: productId,
                     position: position,
                     createdAt: createdAt,
                     updatedAt: updatedAt,
                     width: width,
                     height: height,
                     src: src)
    }
}

