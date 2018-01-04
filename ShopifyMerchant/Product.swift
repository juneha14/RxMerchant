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




struct Variant {
    let id: Int64?
    let productId: Int64?
    let title: String?
    let price: Double?
    let sku: String?
    let position: Int?
    let inventoryPolicy: String?
    let compareAtPrice: Double?
    let fulfillmentService: String?
    let option1: String?
    let option2: String?
    let option3: String?
    let createdAt: String?
    let updatedAt: String?
    let taxable: Bool
    let grams: Int?
    let inventoryQuantity: Int?
    let weight: Double?
    let weightUnit: String?
    let requiresShipping: Bool
}

extension Variant: JSONMappable {
    static func fromJSON(_ json: Any) -> Variant {
        let json = JSON(json)
        
        let id = json["id"].int64Value
        let productId = json["product_id"].int64Value
        let title = json["title"].stringValue
        let price = json["price"].doubleValue
        let sku = json["sku"].stringValue
        let position = json["position"].intValue
        let inventoryPolicy = json["inventory_policy"].stringValue
        let compareAtPrice = json["compare_at_price"].doubleValue
        let fulfillmentService = json["fulfillment_service"].stringValue
        let option1 = json["option1"].stringValue
        let option2 = json["option2"].stringValue
        let option3 = json["option3"].stringValue
        let createdAt = json["created_at"].stringValue
        let updatedAt = json["updated_at"].stringValue
        let taxable = json["taxable"].boolValue
        let grams = json["grams"].intValue
        let inventoryQuantity = json["inventory_quantitiy"].intValue
        let weight = json["weight"].doubleValue
        let weightUnit = json["weight_unit"].stringValue
        let requiresShopping = json["requires_shopping"].boolValue

        return Variant(id: id,
                       productId: productId,
                       title: title,
                       price: price,
                       sku: sku,
                       position: position,
                       inventoryPolicy: inventoryPolicy,
                       compareAtPrice: compareAtPrice,
                       fulfillmentService: fulfillmentService,
                       option1: option1,
                       option2: option2,
                       option3: option3,
                       createdAt: createdAt,
                       updatedAt: updatedAt,
                       taxable: taxable,
                       grams: grams,
                       inventoryQuantity: inventoryQuantity,
                       weight: weight,
                       weightUnit: weightUnit,
                       requiresShipping: requiresShopping)
    }
}


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























