// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct OrderResponse: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(Order.self, forKey: CodingKeys.order)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case order
    }

    let order: Order
}
