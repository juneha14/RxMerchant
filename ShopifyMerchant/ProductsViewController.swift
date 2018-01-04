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

struct ProductSectionModel {
    var header: String?
    var items: [Item]
}

extension ProductSectionModel: SectionModelType {
    typealias Item = Product
    
    init(original: ProductSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

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




class ProductsDataSource: DataSource {
    
    
}

open class DataSource: NSObject, UITableViewDataSource {
    
    private var dataSource: [[(data: Any, reuseId: String)]] = []
    
    
    final func clearDataSource() {
        self.dataSource = [[]]
    }
    
    final func set<TableCell: Cell, Data: Any>(data: Data, cellClass: TableCell.Type, section: Int) where TableCell.Data == Data {
        
    }
    
    open func configureCell(cell: UITableViewCell, withData data: Any) { }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

protocol Cell: class {
    associatedtype Data
    static var resuseId: String { get }
    func configuredWith(value: Data)
}










