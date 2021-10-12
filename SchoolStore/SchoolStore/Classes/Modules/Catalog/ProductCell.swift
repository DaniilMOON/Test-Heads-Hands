// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

final class ProductCell: UITableViewCell {
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
            titleLabel.text = model
        }
    }

    // MARK: Private

    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func setup() {
        selectionStyle = .none
        contentView.addSubview(contentImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(separatorView)

        [contentImageView, titleLabel, descriptionLabel, priceLabel, addToCartButton].forEach {
            $0.layer.borderWidth = 0
            $0.layer.borderColor = UIColor.red.cgColor
        }

        contentImageView.image = Asset.imagePlaceholder.image
        contentImageView.top(16).left(16).bottom(16).width(112).height(112)

        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.top(16).left(to: .right(16), of: contentImageView).right(16)

        descriptionLabel.text = "Джерси"
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.top(to: .bottom, of: titleLabel).left(to: .right(16), of: contentImageView).right(16)

        priceLabel.text = "9000"
        priceLabel.bottom(21).left(to: .right(16), of: contentImageView)

        addToCartButton.setTitle(L10n.Product.buy, for: .normal)
        addToCartButton.setTitleColor(Asset.main.color, for: .normal)
        addToCartButton.setImage(Asset.productCart.image, for: .normal)
        addToCartButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        addToCartButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        addToCartButton.top(to: .top, of: priceLabel).bottom(21).right(16)

        separatorView.bottom().left(16).right(16).height(1)
        separatorView.backgroundColor = Asset.separator.color
    }
}
