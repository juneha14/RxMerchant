//
//  ProductsViewModel.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-03.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya


class ProductsViewModel {
    
    let products: Observable<[ProductSectionModel]>
    
    fileprivate let productsProvider: RxMoyaProvider<Products> = ProductProvider
    
    
    init() {
        let productsProvider = self.productsProvider
        
        
        self.products = self.viewDidLoadSubject.asObservable()
            .flatMap { (_) -> Observable<[ProductSectionModel]> in
                return productsProvider.request(Products.getAllProducts)
                    .debug()
                    .mapJson(Product.self, rootKey: "products")
                    .map({ (products) -> [ProductSectionModel] in
                        return [ProductSectionModel(header: nil, items: products)]
                    })
                    .shareReplay(1)
        }
        
        
    }
    
    
    fileprivate let viewDidLoadSubject = PublishSubject<Void>()
    func viewDidLoad() {
        self.viewDidLoadSubject.onNext(())
    }
    
}

