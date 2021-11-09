// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - OrderService

protocol OrderService: AnyObject {
    func sendOrder(quantity: String,
                   house: String,
                   apartment: String,
                   etd: String,
                   productId: String,
                   size: String,
                   completion: ((Result<Void, Error>) -> Void)?)
}

// MARK: - OrderServiceImpl

final class OrderServiceImpl: OrderService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    // MARK: Internal

    typealias SentOrder = DataResponse<OrderResponse>

    func sendOrder(
        quantity: String,
        house: String,
        apartment: String,
        etd: String,
        productId: String,
        size: String,
        completion: ((Result<Void, Error>) -> Void)?
    ) {
        networkProvider.mock(
            OrdersRequest.arrangeOrder(productId: productId, size: size, quantity: quantity, house: house, apartment: apartment, etd: etd),
            completion: { (result: Result<SentOrder, Error>) in
                switch result {
                case .success:
                    debugPrint("success")
                    completion?(Result.success(()))
                case let .failure(error):
                    debugPrint("fail")
                    completion?(Result.failure(error))
                }
            }
        )
    }

    // MARK: Private

    private let networkProvider: NetworkProvider
}
