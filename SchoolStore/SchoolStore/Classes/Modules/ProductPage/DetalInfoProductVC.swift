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
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.addSubview(buyButton)
        buyButton.bottom(24).left(16).right(16).height(44)

        scrollView.addSubview(detalInfoProduct)
        detalInfoProduct.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        detalInfoProduct.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        detalInfoProduct.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        detalInfoProduct.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        detalInfoProduct.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
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
