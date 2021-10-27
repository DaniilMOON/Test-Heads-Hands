// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Product: Decodable, Hashable, Equatable {
    let id: String
    let title: String
    let department: String
    let price: Int
    let badge: ProductBadge
    let preview: String
    let images: [String]
    let sizes: [ProductSizes]
    let description: String
    let details: [String]
}
