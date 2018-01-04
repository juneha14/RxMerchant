//
//  Variant.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import SwiftyJSON

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

