// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import UIKit

// MARK: - CatalogVC

final class CatalogVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Catalog.title

        view.addSubview(tableView)
        tableView.top().left().right().bottom()
        catalogService?.getProductList(with: 0, limit: 20, completion: { result in
            switch result {
            case let .success(items):
                self.items = items
                self.tableView.reloadData()
            case .failure:
                break
            }
        })
    }

    // MARK: Internal

    static let productCellReuseId: String = ProductCell.description()

    var items: [Product] = []

    var snacker: Snacker?

    func setup(with catalogService: CatalogService, _ snacker: Snacker) {
        self.catalogService = catalogService
        self.snacker = snacker
    }

    // MARK: Private

    private var catalogService: CatalogService?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: Self.productCellReuseId)

        return tableView
    }()
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension CatalogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.productCellReuseId, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        cell.model = items[indexPath.row]
        cell.buyButton = { model in
            guard let product = model else {
                return
            }
            self.catalogService?.getProduct(with: product.id, completion: { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case let .success(model):
                    debugPrint("Transition buy to \(model.id)")
                    self.navigationController?.pushViewController(VCFactory.buildOrderFormVC(with: model), animated: true)
                case let .failure(error):
                    self.snacker?.show(snack: error.localizedDescription, with: .error)
                }
            })
        }
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard items.indices.contains(indexPath.row) else {
            return
        }
        catalogService?.getProduct(with: items[indexPath.row].id, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(model):
                debugPrint("Transition to \(model.id)")
                self.navigationController?.pushViewController(VCFactory.buildProductVC(with: model), animated: true)
            case let .failure(error):
                self.snacker?.show(snack: error.localizedDescription, with: .error)
            }
        })
    }
}
