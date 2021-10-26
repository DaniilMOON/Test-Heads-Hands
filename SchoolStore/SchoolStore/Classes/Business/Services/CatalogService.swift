// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CatalogService

protocol CatalogService: AnyObject {
    func getProductList(with offset: Int, limit: Int, completion: ((Result<[Product], Error>) -> Void)?)
    func getProduct(with id: String, completion: ((Result<Product, Error>) -> Void)?)
}

// MARK: - CatalogServiceImpl

final class CatalogServiceImpl: CatalogService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    // MARK: Internal

    func getProductList(with offset: Int, limit: Int, completion: ((Result<[Product], Error>) -> Void)?) {
        networkProvider.mock(CatalogRequest.listOfProducts(offset: offset, limit: limit), completion: {
            (result: Result<DataResponse<CatalogResponse>, Error>) in
            switch result {
            case .success:
                completion?(result.map { obj in obj.data.products })
            case let .failure(error):
                completion?(Result.failure(error))
            }
        })
    }

    func getProduct(with productId: String, completion: ((Result<Product, Error>) -> Void)?) {
        networkProvider.mock(
            CatalogRequest.detailInfo(productId)
        ) { (result: Result<DataResponse<ProductResponse>, Error>) in
            switch result {
            case .success:
                completion?(result.map(\.data.product))
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }

    // MARK: Private

    private let networkProvider: NetworkProvider
}
