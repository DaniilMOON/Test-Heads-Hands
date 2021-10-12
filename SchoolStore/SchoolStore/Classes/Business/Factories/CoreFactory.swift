// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum CoreFactory {
    static let requestBuilder: RequestBuilder = RequestBuilderImpl(dataService: Self.dataService)

    static let networkProvider: NetworkProvider = NetworkProviderImpl(requestBuilder: requestBuilder)

    static let snacker: Snacker = SnackerImpl()

    static let dataService: DataService = DataServiceImpl()

    static func buildAuthService() -> AuthService {
        AuthServiceImpl(networkProvider: Self.networkProvider, dataService: Self.dataService)
    }
}
