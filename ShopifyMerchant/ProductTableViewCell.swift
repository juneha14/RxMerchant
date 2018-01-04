//
//  ProductTableViewCell.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-03.
//  Copyright © 2018 June Ha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ProductTableViewCell: UITableViewCell {
    fileprivate let viewModel: ProductTableViewCellViewModel = ProductTableViewCellViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    func configuredWith(product: Product) {
        self.viewModel.configuredWith(product: product)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindToViewModel()
    }
    
    private func bindToViewModel() {
        
        self.viewModel
            .productImage
            .subscribe(onNext: { [weak self] (src) in
                guard let url = src else {
                    return
                }
                
                self?.productImageView.sd_setImage(with: URL(string: url), placeholderImage: nil, options: .continueInBackground, completed: nil)
            })
            .addDisposableTo(disposeBag)
        
        self.viewModel.titleLabel.bind(to: self.titleLabel.rx.text).addDisposableTo(disposeBag)
        self.viewModel.descriptionText.bind(to: self.descriptionTextView.rx.text).addDisposableTo(disposeBag)
    }

}


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













