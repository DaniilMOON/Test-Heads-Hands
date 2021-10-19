// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct ProductBadge: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: CodingKeys.value)
        color = try container.decode(String.self, forKey: CodingKeys.color)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case value, color
    }

    let value: String
    let color: String
}
