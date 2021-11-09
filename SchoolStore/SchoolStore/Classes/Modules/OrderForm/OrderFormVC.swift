// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

class OrderFormVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = L10n.OrderForm.title

        view.addSubview(orderFormView)
        orderFormView.safeArea { $0.top(16).left().right().bottom(16) }
    }

    // MARK: Internal

    var snacker: Snacker?

    func setup(with product: Product, _ orderService: OrderService, _ snacker: Snacker) {
        self.product = product
        self.orderService = orderService
        self.snacker = snacker
    }

    @objc
    func buyNow() {
        guard let address = orderFormView.addressInputField.text,
              let flatNumber = orderFormView.flatNumberInputField.text,
              let date = orderFormView.dateInputField.text
        else { return }
        let kol = orderFormView.stepperView.text

        if address.isEmpty {
            orderFormView.addressInputField.error = L10n.Common.emptyField
        }

        if flatNumber.isEmpty {
            orderFormView.flatNumberInputField.error = L10n.Common.emptyField
        }

        if date.isEmpty {
            orderFormView.dateInputField.error = L10n.Common.emptyField
        }

        let productId = (product?.id)!
        let size = (product?.sizes[0].value)!
        if !address.isEmpty, !flatNumber.isEmpty, !date.isEmpty {
            orderService?.sendOrder(
                quantity: kol,
                house: address,
                apartment: flatNumber,
                etd: date,
                productId: productId,
                size: size,
                completion: { (result: Result<Void, Error>) in
                    switch result {
                    case .success:
                        self.navigationController?.popToRootViewController(animated: true)
                    case let .failure(error):
                        self.snacker?.show(snack: error.localizedDescription, with: .error)
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            )
        }
    }

    // MARK: Private

    private var orderService: OrderService?

    private let orderFormView: OrderFormView = {
        let orderFormView = OrderFormView()
        orderFormView.translatesAutoresizingMaskIntoConstraints = false
        orderFormView.buyButton.addTarget(self, action: #selector(buyNow), for: .touchUpInside)
        return orderFormView
    }()

    private var product: Product? {
        didSet {
            orderFormView.fillWith(product: product)
        }
    }
}
