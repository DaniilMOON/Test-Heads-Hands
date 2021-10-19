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

    var model: Product? {
        didSet {
            titleLabel.text = model?.title
            departmentLabel.text = model?.department
            var price = String(model?.price ?? 0)
            price = String(price.reversed())
            var newPrice: String = ""
            var kol = 0
            for character in price {
                newPrice = String(character) + newPrice
                kol += 1
                kol %= 3
                if kol == 0 {
                    newPrice = " " + newPrice
                }
            }
            priceLabel.text = newPrice + " ₽"

            let url = URL(string: model!.preview)
            let task = URLSession.shared.dataTask(with: url!) { data, _, _ in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.contentImageView.image = UIImage(data: data)
                }
            }
            task.resume()
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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var departmentLabel: UILabel = {
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
        contentView.addSubview(departmentLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(separatorView)

        [contentImageView, titleLabel, departmentLabel, priceLabel, addToCartButton].forEach {
            $0.layer.borderWidth = 0
            $0.layer.borderColor = UIColor.red.cgColor
        }

        contentImageView.image = Asset.imagePlaceholder.image
        contentImageView.top(16).left(16).bottom(16).width(112).height(112)

        titleLabel.textColor = textPrimaryColor
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.top(16).left(to: .right(16), of: contentImageView).right(16)

        departmentLabel.textColor = textSecondaryColor
        departmentLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        departmentLabel.top(to: .bottom, of: titleLabel).left(to: .right(16), of: contentImageView).right(16)
        // departmentLabel.text = "Джерси"

        priceLabel.textColor = textPrimaryColor
        priceLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        priceLabel.bottom(21).left(to: .right(16), of: contentImageView)
        // priceLabel.text = "9 000 ₽"

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
