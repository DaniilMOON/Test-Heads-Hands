// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

final class HistoryCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Internal

    var model: String? {
        didSet {
            orderLabel.text = model
        }
    }

    // MARK: Private

    private let textPrimaryColor: UIColor = Asset.textPrimary.color
    private let textSecondaryColor: UIColor = Asset.textSecondary.color

    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var orderStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func setup() {
        selectionStyle = .none
        contentView.addSubview(contentImageView)
        contentView.addSubview(orderLabel)
        contentView.addSubview(orderStatusLabel)
        contentView.addSubview(productLabel)
        contentView.addSubview(deliveryTimeLabel)
        contentView.addSubview(separatorView)

        [contentImageView, orderLabel, orderStatusLabel, productLabel, deliveryTimeLabel].forEach {
            $0.layer.borderWidth = 0
            $0.layer.borderColor = UIColor.red.cgColor
        }

        contentImageView.image = Asset.imagePlaceholder.image
        contentImageView.top(16).left(16).height(64).width(64)

        orderLabel.textColor = textPrimaryColor
        orderLabel.font = UIFont(name: "Roboto-Medium", size: 10)
        orderLabel.top(16).left(to: .right(8), of: contentImageView).right(16)

        // orderStatusLabel.textColor = textPrimaryColor
        orderStatusLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        orderStatusLabel.top(to: .bottom(8), of: orderLabel).left(to: .right(8), of: contentImageView).right(16)
        orderStatusLabel.text = "В работе"

        productLabel.textColor = textPrimaryColor
        productLabel.font = UIFont(name: "Roboto-Medium", size: 12)
        productLabel.lineBreakMode = .byWordWrapping
        productLabel.numberOfLines = 0
        productLabel.top(to: .bottom(8), of: orderStatusLabel).left(to: .right(8), of: contentImageView).right(16)
        productLabel.text = "4 × M • Nike Tampa Bay Buccaneers Super Bowl LV"

        deliveryTimeLabel.textColor = textSecondaryColor
        deliveryTimeLabel.font = UIFont(name: "Roboto-Medium", size: 10)
        deliveryTimeLabel.lineBreakMode = .byWordWrapping
        deliveryTimeLabel.numberOfLines = 0
        deliveryTimeLabel.top(to: .bottom(8), of: productLabel).left(to: .right(8), of: contentImageView).bottom(16).right(16)
        deliveryTimeLabel.text = "Дата доставки: 24.09.21 в 16:00\nАдрес доставки: г. Саранск, ул. Демократическая, 14"

        separatorView.bottom().left(16).right(16).height(1)
        separatorView.backgroundColor = Asset.separator.color
    }
}
