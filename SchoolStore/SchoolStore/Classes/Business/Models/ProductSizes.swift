// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct ProductSizes: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: CodingKeys.value)
        is_available = try container.decode(String.self, forKey: CodingKeys.is_available)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case value, is_available
    }

    let value: String
    let is_available: String
}
