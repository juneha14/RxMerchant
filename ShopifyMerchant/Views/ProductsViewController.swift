//
//  ProductsViewController.swift
//  ShopifyMerchant
//
//  Created by June Ha on 2018-01-03.
//  Copyright © 2018 June Ha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SDWebImage

class ProductsViewController: UIViewController {
    fileprivate let viewModel = ProductsViewModel()
    fileprivate var dataSource = RxTableViewSectionedReloadDataSource<ProductSectionModel>()
    fileprivate let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    static func instantiate() -> ProductsViewController {
        let vc = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductsVC") as! ProductsViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        setupTableViewDataSource(self.dataSource)
        bindToViewModel()
        
        self.viewModel.viewDidLoad()
    }

    
    private func configureTableView() {
        self.tableView.estimatedRowHeight = 135.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
    }
    
    private func setupTableViewDataSource(_ dataSource: RxTableViewSectionedReloadDataSource<ProductSectionModel>) {
        dataSource.configureCell = { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
            cell.configuredWith(product: item)
            return cell
        }
    }
    
    private func bindToViewModel() {
        
        self.viewModel
            .products
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .addDisposableTo(disposeBag)
        
    }
    
    

}

