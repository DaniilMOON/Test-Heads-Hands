// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - GetListOfProductResponse

struct GetListOfProductResponse: Decodable {
    let products: [Product]
}

// MARK: - GetDetailInfoResponse

struct GetDetailInfoResponse: Decodable {
    let product: Product
}
