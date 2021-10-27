// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import UIKit

// MARK: - HistoryVC

final class HistoryVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        segmentedControl.left().right().safeArea { $0.top() }
        tableView.top(to: .bottom, of: segmentedControl).left().right().bottom()

        configTableView()
        historyService?.getHistoryItems(with: 0, limit: 20, completion: { [weak self] result in
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

    static let historyCellReuseId: String = HistoryCell.description()

    var items: [Order] = [] {
        didSet {
            snapshot(items)
        }
    }

    func setup(with historyService: HistoryService, _ snacker: Snacker) {
        self.historyService = historyService
        self.snacker = snacker
    }

    func configTableView() {
        dataSource = UITableViewDiffableDataSource<SimpleDiffableSection, Order>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, model -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Self.historyCellReuseId,
                    for: indexPath
                ) as? HistoryCell else {
                    return nil
                }
                cell.model = model
                return cell
            }
        )
    }

    func snapshot(_ items: [Order]) {
        var snapshot = NSDiffableDataSourceSnapshot<SimpleDiffableSection, Order>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    func loadNextPage() {
        isLoadingNextPage = true
        historyService?.getHistoryItems(with: items.count, limit: 12, completion: { [weak self] result in
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

    private var dataSource: UITableViewDiffableDataSource<SimpleDiffableSection, Order>?

    private var snacker: Snacker?
    private var historyService: HistoryService?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.register(
            HistoryCell.self,
            forCellReuseIdentifier: Self.historyCellReuseId
        )
        tableView.register(HistoryCell.self, forCellReuseIdentifier: Self.historyCellReuseId)

        return tableView
    }()

    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: [L10n.History.SegmentedControl.all, L10n.History.SegmentedControl.active])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(selectSegment), for: .valueChanged)
        return sc
    }()

    private var isLoadingNextPage: Bool = false {
        didSet {
            loadFooterView(load: isLoadingNextPage)
        }
    }

    @objc
    private func selectSegment(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            break
        default:
            break
        }
    }
}

// MARK: UITableViewDelegate

extension HistoryVC: UITableViewDelegate {
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
}
