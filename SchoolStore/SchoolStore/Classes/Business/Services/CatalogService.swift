// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - CatalogService

protocol CatalogService: AnyObject {
    func getListOfProducts(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?)
}

// MARK: - CatalogServiceImpl

final class CatalogServiceImpl: CatalogService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Internal

    typealias Authenticateed = DataResponse<AuthResponse>

    func getListOfProducts(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?) {
        networkProvider.mock(UserRequest.login(user: user, password: password)) { [weak self] (result: Result<Authenticateed, Error>) in
            switch result {
            case let .success(data):
                let token = data.data.accessToken
                self?.dataService.appState.accessToken = token
                completion?(Result.success(token))
            case let .failure(error):
                completion?(Result.failure(error))
            }
        }
    }

    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}
