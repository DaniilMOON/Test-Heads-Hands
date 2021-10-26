// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - GetListOfProductResponse

struct CatalogResponse: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decode([Product].self, forKey: CodingKeys.products)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case products
    }

    let products: [Product]
}
