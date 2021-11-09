// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Kingfisher
import UIKit

class ProductView: UIView {
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

    // MARK: Internal

    func fillWith(product: Product?) {
        guard let product = product else {
            return
        }
        /* badgeLabel

         sizeLabel*/

        if let previewUrl = URL(string: product.preview) {
            let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: product.preview)
            mainImageView.kf.setImage(
                with: contentImageResource,
                placeholder: Asset.imagePlaceholder.image,
                options: [
                    .transition(.fade(0.2)),
                    .forceTransition,
                    .cacheOriginalImage,
                    .keepCurrentImageWhileLoading,
                ]
            )
        } else {
            mainImageView.image = Asset.imagePlaceholder.image
        }

        var imagesProduct: [String] = product.images
        imagesProduct.insert(product.preview, at: 0)

        imagesProduct.forEach { preview in
            let buton = UIButton()
            buton.translatesAutoresizingMaskIntoConstraints = false

            let previewView: UIImageView = {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            buton.addSubview(previewView)
            buton.height(32).width(32)
            buton.layer.borderWidth = 1

            previewView.pinToSuperview()

            if let previewUrl = URL(string: preview) {
                let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: preview)
                previewView.kf.setImage(
                    with: contentImageResource,
                    placeholder: Asset.imagePlaceholder.image,
                    options: [
                        .transition(.fade(0.2)),
                        .forceTransition,
                        .cacheOriginalImage,
                        .keepCurrentImageWhileLoading,
                    ]
                )
            } else {
                previewView.image = Asset.imagePlaceholder.image
            }

            buton.addTarget(self, action: #selector(previewDidTap), for: .touchUpInside)
            previewsStackView.addArrangedSubview(buton)
        }

        let price = product.price as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumSignificantDigits = 0
        formatter.locale = Locale(identifier: "ru_RU")
        priceLabel.text = formatter.string(from: price)

        badgeLabel.text = product.badge.value
        badgeLabel.backgroundColor = hexStringToUIColor(hex: product.badge.color)

        titleLabel.text = product.title
        departmentLabel.text = product.department

        descriptionLabel.text = product.description

        detailsLabel.text = ""
        for line in product.details {
            if line != "" {
                detailsLabel.text! += line + "\n"
            }
        }
    }

    // MARK: Private

    private let textPrimaryColor: UIColor = Asset.textPrimary.color
    private let textSecondaryColor: UIColor = Asset.textSecondary.color

    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var previewsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var badgeLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.paddingLeft = 12
        label.paddingRight = 12
        label.paddingTop = 2
        label.paddingBottom = 2
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

    private func hexStringToUIColor(hex: String) -> UIColor? {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        if hexString.count != 8 {
            while hexString.count != 8 {
                hexString += "F"
            }
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF00_0000) >> 24) / 255.0,
            green: CGFloat((rgbValue & 0x00FF_0000) >> 16) / 255.0,
            blue: CGFloat((rgbValue & 0x0000_FF00) >> 8) / 255.0,
            alpha: CGFloat(rgbValue & 0x0000_00FF) / 255.0
        )
    }

    @objc
    private func previewDidTap(_ sender: UIButton) {
        guard let imageView = sender.subviews.first(where: { $0 is UIImageView }) as? UIImageView,
              let image = imageView.image
        else {
            return
        }
        mainImageView.image = image
    }

    private func setup() {
        addSubview(mainImageView)
        addSubview(scrollView)
        addSubview(priceLabel)
        addSubview(badgeLabel)
        addSubview(titleLabel)
        addSubview(departmentLabel)
        addSubview(sizeLabel)
        addSubview(descriptionLabel)
        addSubview(separatorView)
        addSubview(detailsLabel)

        // mainImageView.image = Asset.imagePlaceholder.image
        mainImageView.top(16).centerX().width(284).height(284)

        scrollView.addSubview(previewsStackView)

        scrollView
            .top(to: .bottom(20), of: mainImageView)
            .height(32)

        scrollView.widthAnchor
            .constraint(lessThanOrEqualTo: previewsStackView.widthAnchor)
            .priority(999)
            .activate()

        scrollView.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
            .activate()

        scrollView.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
            .activate()

        previewsStackView.top().bottom().centerX().height(as: scrollView)

        // priceLabel.text = "9 000 ₽"
        priceLabel.textColor = textPrimaryColor
        priceLabel.font = UIFont(name: "Roboto-Medium", size: 24)
        priceLabel.top(to: .bottom(20), of: scrollView).left(16)

        // badgeLabel.text = "Хит сезона"
        // badgeLabel.backgroundColor = .red
        badgeLabel.font = UIFont(name: "Roboto-Regular", size: 20)
        badgeLabel.textColor = Asset.white.color
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = 12
        badgeLabel.right(16).centerY(0, to: priceLabel)

        // titleLabel.text = "Men's Nike Tom Brady Red Tampa Bay Buccaneers Super Bowl LV Bound Game Jersey"
        titleLabel.textColor = textPrimaryColor
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 20)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.top(to: .bottom(16), of: priceLabel).left(16).right(16)

        // departmentLabel.text = "Джерси"
        departmentLabel.textColor = textSecondaryColor
        departmentLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        departmentLabel.top(to: .bottom(4), of: titleLabel).left(16)

        sizeLabel.backgroundColor = .systemGray2
        sizeLabel.top(to: .bottom(16), of: departmentLabel).left(16).right(16).height(54)

        /* descriptionLabel
         .text =
         "The Tampa Bay Buccaneers are headed to Super Bowl LV! As a major fan, this is no surprise but it's definitely worth celebrating, especially after the unprecedented 2020 NFL season. Add this Tom Brady Game Jersey to your collection to ensure you're Super Bowl ready. This Nike gear features bold commemorative graphics that will let the Tampa Bay Buccaneers know they have the best fans in the league." */
        descriptionLabel.textColor = textPrimaryColor
        descriptionLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.top(to: .bottom(16), of: sizeLabel).left(16).right(16)

        separatorView.backgroundColor = Asset.grey.color
        separatorView.top(to: .bottom(16), of: descriptionLabel).left(16).right(16).height(1)

        /* detailsLabel
         .text =
         "Material: 100% Polyester\nFoam tongue helps reduce lace pressure.\nMesh in the upper provides a breathable and plush sensation that stretches with your foot.\nMidfoot webbing delivers security. The webbing tightens around your foot when you lace up, letting you choose your fit and feel.\nNike React foam is lightweight, springy and durable. More foam means better cushioning without the bulk. A Zoom Air unit in the forefoot delivers more bounce with every step. It's top-loaded to be closer to your foot for responsiveness.\nThe classic fit and feel of the Pegasus is back—with a wider toe box to provide extra room. Seaming on the upper provides a better shape and fit, delivering a fresh take on an icon.\nOfficially licensed\nImported\nBrand: Nike" */
        detailsLabel.textColor = textSecondaryColor
        detailsLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        detailsLabel.lineBreakMode = .byWordWrapping
        detailsLabel.numberOfLines = 0
        detailsLabel.top(to: .bottom(16), of: separatorView).left(16).right(16).bottom(60)
    }
}
