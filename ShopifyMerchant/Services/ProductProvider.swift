//
//  ProductProvider.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import Moya

let ProductProvider = RxMoyaProvider<Products>(endpointClosure: listingsEndpointClosure)

enum Products {
    case getAllProducts
}

extension Products: TargetType {
    var baseURL: URL { return URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")! }
    
    var path: String {
        switch self {
        case .getAllProducts:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllProducts:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAllProducts:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllProducts:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getAllProducts:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
}

var listingsEndpointClosure = { (target: Products) -> Endpoint<Products> in
    let base = target.baseURL
    //    let path = URL(string: target.path)!
    let url = "\(base)"
    let endpoint: Endpoint<Products> = Endpoint(url: url,
                                                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                                method: target.method,
                                                parameters: target.parameters,
                                                parameterEncoding: target.parameterEncoding)
    return endpoint.adding(newHTTPHeaderFields: ["Content-Type": "application/json"])
}

