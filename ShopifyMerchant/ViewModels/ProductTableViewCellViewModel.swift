//
//  ProductTableViewCellViewModel.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxSwift

class ProductTableViewCellViewModel {
    
    let productImage: Observable<String?>
    let titleLabel: Observable<String?>
    let descriptionText: Observable<String?>
    
    init() {
        
        self.productImage = self.configDataSubject.asObservable()
            .map({ (product) -> String? in
                return product.image?.src
            })
        
        self.titleLabel = self.configDataSubject.asObservable()
            .map({ (product) -> String? in
                return product.title
            })
        
        self.descriptionText = self.configDataSubject.asObservable()
            .map({ (product) -> String? in
                return product.bodyHtml
            })
        
    }
    
    
    fileprivate let configDataSubject = PublishSubject<Product>()
    func configuredWith(product: Product) {
        self.configDataSubject.onNext(product)
    }
    
}

