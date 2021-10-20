// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import UIKit

class DetalInfoProductVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(
            title: L10n.DetalInfoProduct.back,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(backButtonPressed)
        )
        navigationItem.leftBarButtonItem = backButton

        view.addSubview(scrollView)
        scrollView.safeArea { $0.top().left().right().bottom() }

        scrollView.addSubview(detalInfoProduct)
        detalInfoProduct.top().left().right().bottom().width(as: scrollView)

        view.addSubview(buyButton)
        buyButton.left(16).right(16).height(44).safeArea { $0.bottom() }
    }

    // MARK: Internal

    @objc func backButtonPressed() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildTabBarVC()
    }

    // MARK: Private

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var buyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle(L10n.DetalInfoProduct.buyNow, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()

    private var product: Product?

    private let detalInfoProduct = DetalInfoProductPage()
}
