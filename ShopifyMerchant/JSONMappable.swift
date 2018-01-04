//
//  JSONMappable.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-03.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol JSONMappable {
    static func fromJSON(_ json: Any) -> Self
}

extension JSONMappable {
    static func fromJSONArray(_ json: [Any]) -> [Self] {
        return json.map { Self.fromJSON($0) }
    }
}

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

