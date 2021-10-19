// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CatalogService

protocol CatalogService: AnyObject {
    func getProductList(limit: Int, offset: Int, completion: ((Result<[Product], Error>) -> Void)?)
}

// MARK: - CatalogServiceImpl

final class CatalogServiceImpl: CatalogService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    // MARK: Internal

    typealias ProductList = DataResponse<GetListOfProductResponse>

    func getProductList(limit _: Int, offset _: Int, completion: ((Result<[Product], Error>) -> Void)?) {
        networkProvider.mock(CatalogRequest.listOfProducts, completion: {
            (result: Result<ProductList, Error>) in
            switch result {
            case .success:
                completion?(result.map { obj in obj.data.products })
            case let .failure(error):
                completion?(Result.failure(error))
            }
        })
    }

    // MARK: Private

    private let networkProvider: NetworkProvider
}
