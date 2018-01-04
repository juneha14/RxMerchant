//
//  ProductSectionModel.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxDataSources

struct ProductSectionModel {
    var header: String?
    var items: [Item]
}

extension ProductSectionModel: SectionModelType {
    typealias Item = Product
    
    init(original: ProductSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

