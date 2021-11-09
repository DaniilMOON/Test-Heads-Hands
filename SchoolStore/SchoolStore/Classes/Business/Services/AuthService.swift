// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - AuthService

protocol AuthService: AnyObject {
    func authenticate(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?)
    func getProfile(completion: ((Result<Profile, Error>) -> Void)?)
}

// MARK: - AuthServiceImpl

final class AuthServiceImpl: AuthService {
    // MARK: Lifecycle

    init(networkProvider: NetworkProvider, dataService: DataService) {
        self.networkProvider = networkProvider
        self.dataService = dataService
    }

    // MARK: Internal

    typealias Authenticated = DataResponse<AuthResponse>

    func authenticate(user: String, with password: String, completion: ((Result<String, Error>) -> Void)?) {
        networkProvider.mock(UserRequest.login(user: user, password: password)) { [weak self] (result: Result<Authenticated, Error>) in
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

    func getProfile(completion: ((Result<Profile, Error>) -> Void)?) {
        networkProvider.mock(
            UserRequest.userGet,
            completion: { (result: Result<DataResponse<ProfileResponse>, Error>) in
                switch result {
                case .success:
                    completion?(result.map(\.data.profile))
                case let .failure(error):
                    completion?(Result.failure(error))
                }
            }
        )
    }

    // MARK: Private

    private let networkProvider: NetworkProvider

    private let dataService: DataService
}
