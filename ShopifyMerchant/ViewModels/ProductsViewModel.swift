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
    let segueToProductDetailsScreen: Observable<Product>
    
    fileprivate let productsProvider: RxMoyaProvider<Products> = ProductProvider
    
    
    init() {
        let productsProvider = self.productsProvider
        let productsVariable: Variable<[ProductSectionModel]> = Variable([])
        
        
        self.products = self.viewDidLoadSubject.asObservable()
            .flatMap { (_) -> Observable<[ProductSectionModel]> in
                return productsProvider.request(Products.getAllProducts)
                    .debug()
                    .mapJson(Product.self, rootKey: "products")
                    .map({ (products) -> [ProductSectionModel] in
                        return [ProductSectionModel(header: nil, items: products)]
                    })
                    .do(onNext: { (products) in
                        productsVariable.value = products
                    })
                    .shareReplay(1)
            }
        
        self.segueToProductDetailsScreen = self.productCellSelectedSubject.asObservable()
            .map { (indexPath) -> Product in
                return productsVariable.value[indexPath.section].items[indexPath.row]
            }
        
        
    }
    
    
    fileprivate let viewDidLoadSubject = PublishSubject<Void>()
    func viewDidLoad() {
        self.viewDidLoadSubject.onNext(())
    }
    
    fileprivate let productCellSelectedSubject = PublishSubject<IndexPath>()
    func productCellSelected(withIndexPath indexPath: IndexPath) {
        self.productCellSelectedSubject.onNext(indexPath)
    }
    
}

