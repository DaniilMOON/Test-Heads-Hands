// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - RequestBuilder

protocol RequestBuilder: AnyObject {
    func build(_ requestTarget: Request) -> URLRequest?
}

// MARK: - RequestBuilderImpl

final class RequestBuilderImpl: RequestBuilder {
    // MARK: Lifecycle

    init(dataService: DataService) {
        self.dataService = dataService
    }

    // MARK: Public

    public func build(_ requestTarget: Request) -> URLRequest? {
        guard let baseURL = URL(string: prefixHTTPs("\(apiURL)/"))
        else {
            return nil
        }
        var url = baseURL.appendingPathComponent(requestTarget.path)
        if let urlParams = requestTarget.urlParameters, let urlWithQueryParameters = append(to: url, urlParams) {
            url = urlWithQueryParameters
        }
        var request = URLRequest(url: url)
        request.setValue(requestTarget.contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = requestTarget.method.rawValue.uppercased()
        request.httpBody = requestTarget.body
        requestTarget.regularHeaders.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return authenticate(requestTarget, request: &request)
    }

    // MARK: Internal

    //
    // NOTE:
    //
    // You can use here dicioonary of type [String: Any] as method's `data` argument or any data, that implements
    // `Encodable` protocol. Maybe, something like
    //
    // struct LoginPayload: Encodable {
    //     let login: String
    //     let password: String
    // }
    //
    // RequestBuilderImpl.encode(LoginPayload(...))
    //
    static func encode<T: Encodable>(
        _ data: T,
        encoderKeyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys,
        encoderDateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601
    ) -> Data? {
        if let json = data as? [String: Any] {
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        } else {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = encoderKeyEncodingStrategy
            encoder.dateEncodingStrategy = encoderDateEncodingStrategy
            return try? encoder.encode(data)
        }
    }

    // MARK: Private

    private let dataService: DataService
    private let apiURL: String = "api.com/"

    private func prefixHTTPs(_ url: String) -> String {
        let prefix = "https://"
        return url.contains(prefix) ? url : prefix + url
    }

    private func append(to url: URL, _ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }

    private func authenticate(_ target: Request, request: inout URLRequest) -> URLRequest? {
        if target.authenticated, let accessToken = dataService.appState.accessToken {
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
