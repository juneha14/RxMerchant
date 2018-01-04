//
//  Product.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-03.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Product {
    let id: Int64?
    let title: String?
    let bodyHtml: String?
    let vendor: String?
    let productType: String?
    let createdAt: String?
    let handle: String?
    let updatedAt: String?
    let publishedAt: String?
    let publishedScope: String?
    let tags: String?
    let variants: [Variant]?
    let options: [Option]?
    let images: [Image]?
    let image: Image?
}

extension Product: JSONMappable {
    static func fromJSON(_ json: Any) -> Product {
        let json = JSON(json)
        
        let id = json["id"].int64Value
        let title = json["title"].stringValue
        let bodyHtml = json["body_html"].stringValue
        let vendor = json["vendor"].stringValue
        let productType = json["product_type"].stringValue
        let createdAt = json["created_at"].stringValue
        let handle = json["handle"].stringValue
        let updatedAt = json["updated_at"].stringValue
        let publishedAt = json["published_at"].stringValue
        let publishedScope = json["published_scope"].stringValue
        let tags = json["tags"].stringValue
        let variants = Variant.fromJSONArray((json["variants"].arrayObject)!)
        let options = Option.fromJSONArray((json["options"].arrayObject!))
        let images = Image.fromJSONArray((json["images"].arrayObject!))
        let image = Image.fromJSON(json["image"].object)
        
        return Product(id: id,
                       title: title,
                       bodyHtml: bodyHtml,
                       vendor: vendor,
                       productType: productType,
                       createdAt: createdAt,
                       handle: handle,
                       updatedAt: updatedAt,
                       publishedAt: publishedAt,
                       publishedScope: publishedScope,
                       tags: tags,
                       variants: variants,
                       options: options,
                       images: images,
                       image: image)
    }
}

