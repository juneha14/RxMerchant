//
//  JSONMappable.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-03.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxSwift

protocol JSONMappable {
    static func fromJSON(_ json: Any) -> Self
}

extension JSONMappable {
    static func fromJSONArray(_ json: [Any]) -> [Self] {
        return json.map { Self.fromJSON($0) }
    }
}

