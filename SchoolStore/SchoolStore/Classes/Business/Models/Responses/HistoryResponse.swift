// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct HistoryResponse: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orders = try container.decode([Order].self, forKey: CodingKeys.orders)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case orders
    }

    let orders: [Order]
}
