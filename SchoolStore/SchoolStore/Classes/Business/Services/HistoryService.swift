// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - HistoryService

protocol HistoryService: AnyObject {
    func getHistoryItems(with offset: Int, limit: Int, completion: ((Result<[Order], Error>) -> Void)?)
}

// MARK: - HistoryServiceImpl

final class HistoryServiceImpl: HistoryService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    // MARK: Internal

    typealias Orders = DataResponse<HistoryResponse>

    func getHistoryItems(
        with offset: Int,
        limit: Int,
        completion: ((Result<[Order], Error>) -> Void)?
    ) {
        networkProvider.mock(
            OrdersRequest.listOfOrders(offset: offset, limit: limit)
        ) { (result: Result<Orders, Error>) in
            switch result {
            case .success:
                completion?(result.map(\.data.orders))
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }

    // MARK: Private

    private let networkProvider: NetworkProvider
}
