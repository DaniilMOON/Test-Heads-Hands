// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import UIKit

class DetalInfoProductPage: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Private

    private let textPrimaryColor: UIColor = Asset.textPrimary.color
    private let textSecondaryColor: UIColor = Asset.textSecondary.color

    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var firstMiniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var secondMiniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var thirdMiniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setup() {
        addSubview(mainImageView)
        addSubview(firstMiniImageView)
        addSubview(secondMiniImageView)
        addSubview(thirdMiniImageView)
        addSubview(priceLabel)
        addSubview(badgeLabel)
        addSubview(titleLabel)
        addSubview(departmentLabel)
        addSubview(sizeLabel)
        addSubview(descriptionLabel)
        addSubview(separatorView)
        addSubview(detailsLabel)

        mainImageView.image = Asset.imagePlaceholder.image
        mainImageView.top().centerX().width(284).height(284)

        secondMiniImageView.image = Asset.imagePlaceholder.image
        secondMiniImageView.top(to: .bottom(20), of: mainImageView).centerX().width(32).height(32)

        firstMiniImageView.image = Asset.imagePlaceholder.image
        firstMiniImageView.top(to: .top, of: secondMiniImageView)
            .right(to: .left(10), of: secondMiniImageView).width(32).height(32)

        thirdMiniImageView.image = Asset.imagePlaceholder.image
        thirdMiniImageView.top(to: .top, of: secondMiniImageView)
            .left(to: .right(10), of: secondMiniImageView).width(32).height(32)

        priceLabel.text = "9 000 ₽"
        priceLabel.textColor = textPrimaryColor
        priceLabel.font = UIFont(name: "Roboto-Medium", size: 24)
        priceLabel.top(to: .bottom(20), of: secondMiniImageView).left(16)

        badgeLabel.text = "Хит сезона"
        badgeLabel.backgroundColor = .red
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = 16
        badgeLabel.right(16).centerY(0, to: priceLabel)

        titleLabel.text = "Men's Nike Tom Brady Red Tampa Bay Buccaneers Super Bowl LV Bound Game Jersey"
        titleLabel.textColor = textPrimaryColor
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 20)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.top(to: .bottom(16), of: priceLabel).left(16).right(16)

        departmentLabel.text = "Джерси"
        departmentLabel.textColor = textSecondaryColor
        departmentLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        departmentLabel.top(to: .bottom(4), of: titleLabel).left(16)

        sizeLabel.backgroundColor = .systemGray2
        sizeLabel.top(to: .bottom(16), of: departmentLabel).left(16).right(16).height(54)

        descriptionLabel
            .text =
            "The Tampa Bay Buccaneers are headed to Super Bowl LV! As a major fan, this is no surprise but it's definitely worth celebrating, especially after the unprecedented 2020 NFL season. Add this Tom Brady Game Jersey to your collection to ensure you're Super Bowl ready. This Nike gear features bold commemorative graphics that will let the Tampa Bay Buccaneers know they have the best fans in the league."
        descriptionLabel.textColor = textPrimaryColor
        descriptionLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.top(to: .bottom(16), of: sizeLabel).left(16).right(16)

        separatorView.backgroundColor = Asset.separator.color
        separatorView.top(to: .bottom(16), of: descriptionLabel).left(16).right(16).height(1)

        detailsLabel
            .text =
            "Material: 100% Polyester\nFoam tongue helps reduce lace pressure.\nMesh in the upper provides a breathable and plush sensation that stretches with your foot.\nMidfoot webbing delivers security. The webbing tightens around your foot when you lace up, letting you choose your fit and feel.\nNike React foam is lightweight, springy and durable. More foam means better cushioning without the bulk. A Zoom Air unit in the forefoot delivers more bounce with every step. It's top-loaded to be closer to your foot for responsiveness.\nThe classic fit and feel of the Pegasus is back—with a wider toe box to provide extra room. Seaming on the upper provides a better shape and fit, delivering a fresh take on an icon.\nOfficially licensed\nImported\nBrand: Nike"
        detailsLabel.textColor = textSecondaryColor
        detailsLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        detailsLabel.lineBreakMode = .byWordWrapping
        detailsLabel.numberOfLines = 0
        detailsLabel.top(to: .bottom(16), of: separatorView).left(16).right(16).bottom(76)
    }
}
