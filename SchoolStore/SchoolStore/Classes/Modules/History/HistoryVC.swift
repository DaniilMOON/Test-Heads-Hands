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
        segmentedControl.top(92).left().right()
        tableView.top(to: .bottom, of: segmentedControl).left().right().bottom()

        /* let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
         stackView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(stackView)
         stackView.axis = .vertical
         stackView.centerY().right().bottom().left() */

        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [weak self] in
            self?.items = [
                "Заказ №123 от 19.09.21 18:03",
                "Заказ №124 от 19.09.21 18:03",
                "Заказ №125 от 19.09.21 18:03",
                "Заказ №126 от 19.09.21 18:03",
                "Заказ №127 от 19.09.21 18:03",
            ]
            self?.tableView.reloadData()
        }
    }

    // MARK: Internal

    static let historyCellReuseId: String = HistoryCell.description()

    var items: [String] = []

    // MARK: Private

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
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

    @objc
    private func selectSegment(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            items = [
                "Заказ №123 от 19.09.21 18:03",
                "Заказ №124 от 19.09.21 18:03",
                "Заказ №125 от 19.09.21 18:03",
                "Заказ №126 от 19.09.21 18:03",
                "Заказ №127 от 19.09.21 18:03",
            ]
            tableView.reloadData()
        case 1:
            items = [
                "Заказ №123 от 19.09.21 18:03",
                "Заказ №124 от 19.09.21 18:03",
                "Заказ №127 от 19.09.21 18:03",
            ]
            tableView.reloadData()
        default:
            break
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.historyCellReuseId, for: indexPath) as? HistoryCell else {
            return UITableViewCell()
        }
        cell.model = items[indexPath.row]
        return cell
    }
}
