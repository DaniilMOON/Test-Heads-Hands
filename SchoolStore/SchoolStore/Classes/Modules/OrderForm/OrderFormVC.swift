// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

class OrderFormVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.safeArea { $0.top(16).left().right().bottom(16) }

        scrollView.addSubview(orderFormView)
        orderFormView.top().left().right().bottom().width(as: scrollView)

        view.addSubview(buyButton)
        buyButton.left(16).right(16).height(44).safeArea { $0.bottom(16) }
    }

    // MARK: Internal

    var snacker: Snacker?

    func setup(with product: Product, _ snacker: Snacker) {
        self.product = product
        self.snacker = snacker
    }

    // MARK: Private

    private lazy var buyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Asset.main.color
        button.setTitle(L10n.OrderForm.buyNow, for: .normal)
        button.layer.cornerRadius = 12
        // button.addTarget(self, action: #selector(buyNow), for: .touchUpInside)
        return button
    }()

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let orderFormView = OrderFormView()

    private var product: Product? {
        didSet {
            orderFormView.fillWith(product: product)
        }
    }
}
