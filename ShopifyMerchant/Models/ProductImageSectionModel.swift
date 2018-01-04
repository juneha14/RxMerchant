//
//  ProductImageSectionModel.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxDataSources

struct ProductImageSectionModel {
    var header: String?
    var items: [Item]
}

extension ProductImageSectionModel: SectionModelType {
    typealias Item = Image
    
    init(original: ProductImageSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

