//
//  ProductDetailViewModel.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import Foundation
import RxSwift

class ProductDetailViewModel {
    
    let productImagesDataSource: Observable<[ProductImageSectionModel]>
    let totalImageCount: Observable<String?>
    let title: Observable<String?>
    let description: Observable<String?>
    let tags: Observable<String?>
    
    init() {
        
        self.productImagesDataSource = self.viewDidLoadSubject.asObservable()
            .withLatestFrom(self.configDataVariable.asObservable())
            .map { (product) -> [ProductImageSectionModel] in
                return [ProductImageSectionModel(header: nil, items: (product?.images)!)]
        }
        
        self.totalImageCount = self.viewDidLoadSubject.asObservable()
            .withLatestFrom(self.configDataVariable.asObservable())
            .map { (product) -> String? in
                guard let p = product, let i = p.images else {
                    return "0"
                }
                return String(i.count)
        }
        
        self.title = self.viewDidLoadSubject.asObservable()
            .withLatestFrom(self.configDataVariable.asObservable())
            .map { (product) -> String? in
                return product?.title
        }
        
        self.description = self.viewDidLoadSubject.asObservable()
            .withLatestFrom(self.configDataVariable.asObservable())
            .map { (product) -> String? in
                return product?.bodyHtml
        }
        
        self.tags = self.viewDidLoadSubject.asObservable()
            .withLatestFrom(self.configDataVariable.asObservable())
            .map { (product) -> String? in
                return product?.tags
        }
        
    }
    
    fileprivate let configDataVariable = Variable<Product?>(nil)
    func configuredWith(product: Product) {
        self.configDataVariable.value = product
    }
    
    fileprivate let viewDidLoadSubject = PublishSubject<Void>()
    func viewDidLoad() {
        self.viewDidLoadSubject.onNext(())
    }
    
}

