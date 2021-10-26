// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import UIKit

class ProductVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.safeArea { $0.top(16).left().right().bottom(16) }

        scrollView.addSubview(detalInfoProduct)
        detalInfoProduct.top().left().right().bottom().width(as: scrollView)

        view.addSubview(buyButton)
        buyButton.left(16).right(16).height(44).safeArea { $0.bottom(16) }
    }

    // MARK: Internal

    var snacker: Snacker?

    func setup(with catalogService: CatalogService, _ product: Product, _ snacker: Snacker) {
        self.catalogService = catalogService
        self.product = product
        self.snacker = snacker
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
        button.backgroundColor = Asset.main.color
        button.setTitle(L10n.DetalInfoProduct.buyNow, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(orderNow), for: .touchUpInside)
        return button
    }()

    private let detalInfoProduct = ProductView()

    private var catalogService: CatalogService?

    private var product: Product? {
        didSet {
            detalInfoProduct.fillWith(product: product)
        }
    }

    @objc
    private func orderNow(_: UIButton) {
        guard let product = product else {
            return
        }
        catalogService?.getProduct(with: product.id, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(model):
                debugPrint("Transition buy to \(model.id)")
                self.navigationController?.pushViewController(VCFactory.buildOrderFormVC(with: model), animated: true)
            case let .failure(error):
                self.snacker?.show(snack: error.localizedDescription, with: .error)
            }
        })
    }
}
