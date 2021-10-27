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

        configTableView()
        catalogService?.getProductList(with: 0, limit: 20, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(products):
                self.items = products
            case .failure:
                break
            }
        })
    }

    // MARK: Internal

    static let productCellReuseId: String = ProductCell.description()

    var items: [Product] = [] {
        didSet {
            // snapshot(Array(Set(items)))
            snapshot(items)
        }
    }

    func setup(with catalogService: CatalogService, _ snacker: Snacker) {
        self.catalogService = catalogService
        self.snacker = snacker
    }

    func configTableView() {
        dataSource = UITableViewDiffableDataSource<SimpleDiffableSection, Product>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, model -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Self.productCellReuseId,
                    for: indexPath
                ) as? ProductCell else {
                    return nil
                }
                cell.model = model
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
                            debugPrint("Buy to \(model.id)")
                            self.navigationController?.pushViewController(VCFactory.buildOrderFormVC(with: model), animated: true)
                        case let .failure(error):
                            self.snacker?.show(snack: error.localizedDescription, with: .error)
                        }
                    })
                }
                return cell
            }
        )
    }

    func snapshot(_ items: [Product]) {
        var snapshot = NSDiffableDataSourceSnapshot<SimpleDiffableSection, Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    func loadNextPage() {
        isLoadingNextPage = true
        catalogService?.getProductList(with: items.count, limit: 12, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(products):
                self.items += products
            case .failure:
                break
            }
            self.isLoadingNextPage = false
        })
    }

    func loadFooterView(load: Bool) {
        if load {
            let view = UIView()
            view.frame.size = .init(width: view.frame.size.width, height: 60)
            // view.startLoading(with: .smallBlue)
            tableView.tableFooterView = view
        } else {
            tableView.tableFooterView = UIView()
        }
    }

    // MARK: Private

    private enum SimpleDiffableSection: Int, Hashable {
        case main
    }

    private var snacker: Snacker?

    private var dataSource: UITableViewDiffableDataSource<SimpleDiffableSection, Product>?

    private var catalogService: CatalogService?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.register(
            ProductCell.self,
            forCellReuseIdentifier: Self.productCellReuseId
        )
        return tableView
    }()

    private var isLoadingNextPage: Bool = false {
        didSet {
            loadFooterView(load: isLoadingNextPage)
        }
    }
}

// MARK: UITableViewDelegate

extension CatalogVC: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate _: Bool) {
        guard !isLoadingNextPage else { return }
        let offset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height

        if scrollView == tableView {
            if (offset + height) >= contentHeight {
                loadNextPage()
            }
        }
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
