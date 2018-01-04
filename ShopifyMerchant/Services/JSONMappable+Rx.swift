//
//  JSONMappable+Rx.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension ObservableType where E == Response {
    func mapJson<T: JSONMappable>(_: T.Type, rootKey key: String) -> Observable<[T]> {
        return self.mapJSON()
            .map { json -> [T] in
                if let dict = json as? [String: Any], let subJson = dict[key] {
                    return T.fromJSONArray(subJson as! [Any])
                    
                } else {
                    throw ParseError.jsonParsingError
                }
        }
    }
}

enum ParseError: Swift.Error {
    case jsonParsingError
}

