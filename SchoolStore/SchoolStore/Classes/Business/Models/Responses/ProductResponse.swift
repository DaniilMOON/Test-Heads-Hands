// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct ProductResponse: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        product = try container.decode(Product.self, forKey: CodingKeys.product)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case product
    }

    let product: Product
}
