// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - NetworkProvider

protocol NetworkProvider {
    func mock<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?)
    func make<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?)
}

// MARK: - NetworkProviderImpl

final class NetworkProviderImpl: NetworkProvider {
    // MARK: Lifecycle

    init(requestBuilder: RequestBuilder) {
        self.requestBuilder = requestBuilder
        decoder = JSONDecoder()
    }

    // MARK: Internal

    func mock<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?) {
        guard let data = request.mock else {
            completion?(.failure(Errors.unknown))
            return
        }
        if let response = try? decoder.decode(T.self, from: data) {
            completion?(.success(response))
        }
        if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
            completion?(.failure(Errors.failedResponse(message: errorResponse.message, fields: errorResponse.fields)))
        } else {
            completion?(.failure(Errors.unknown))
        }
    }

    func make<T: Decodable>(_ request: Request, completion: ((Result<T, Error>) -> Void)?) {
        guard let urlRequest = requestBuilder.build(request) else {
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            guard let self = self, let data = data else {
                completion?(.failure(Errors.unknown))
                return
            }
            if let response = try? self.decoder.decode(T.self, from: data) {
                completion?(.success(response))
            } else if let errorResponse = try? self.decoder.decode(ErrorResponse.self, from: data) {
                completion?(.failure(Errors.failedResponse(message: errorResponse.message, fields: errorResponse.fields)))
            } else {
                completion?(.failure(Errors.unknown))
            }
        }
        task.resume()
    }

    // MARK: Private

    private let decoder: JSONDecoder

    private let requestBuilder: RequestBuilder
}
