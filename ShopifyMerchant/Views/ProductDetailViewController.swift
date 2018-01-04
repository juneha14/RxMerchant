//
//  ProductDetailViewController.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-04.
//  Copyright © 2018 June Ha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ProductDetailViewController: UIViewController {
    fileprivate let viewModel = ProductDetailViewModel()
    fileprivate var dataSource = RxCollectionViewSectionedReloadDataSource<ProductImageSectionModel>()
    fileprivate let disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentIndexLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    
    static func configuredWith(product: Product) -> ProductDetailViewController {
        let vc = UIStoryboard(name: "ProductDetail", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailViewController
        vc.viewModel.configuredWith(product: product)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewDataSource(self.dataSource)
        bindToViewModel()
        
        self.viewModel.viewDidLoad()
    }

    
    private func setupCollectionViewDataSource(_ dataSource: RxCollectionViewSectionedReloadDataSource<ProductImageSectionModel>) {
        dataSource.configureCell = { (dataSource, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as! ProductImageCollectionViewCell
            cell.productImageView.sd_setImage(with: URL(string: item.src!), placeholderImage: nil, options: .continueInBackground, completed: nil)
            return cell
        }
    }
    
    private func bindToViewModel() {
        self.collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
        
        self.viewModel
            .productImagesDataSource
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .addDisposableTo(disposeBag)
        
        self.viewModel.totalImageCount.bind(to: self.totalCountLabel.rx.text).addDisposableTo(disposeBag)
        self.viewModel.title.bind(to: self.titleLabel.rx.text).addDisposableTo(disposeBag)
        self.viewModel.description.bind(to: self.descriptionTextView.rx.text).addDisposableTo(disposeBag)
        self.viewModel.tags.bind(to: self.tagsLabel.rx.text).addDisposableTo(disposeBag)
        
    }
    
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

