// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - Request

protocol Request {
    var authenticated: Bool { get }
    var path: String { get }
    var method: RequestMethod { get }
    var contentType: String { get }
    var urlParameters: [URLQueryItem]? { get }
    var body: Data? { get }
    var mock: Data? { get }
}

extension Request {
    var authenticated: Bool {
        true
    }

    var contentType: String {
        "application/json"
    }

    var urlParameters: [URLQueryItem]? {
        nil
    }

    var body: Data? {
        nil
    }

    var regularHeaders: [String: String] {
        [
            "Platform": "ios",
        ]
    }

    var mock: Data? {
        nil
    }
}
