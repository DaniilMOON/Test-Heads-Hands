// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Order: Decodable, Hashable, Equatable {
    let id: String
    let number: Int
    let productId: String
    let productPreview: String
    let productQuantity: Int
    let productSize: String
    let createdAt: String
    let etd: String
    let deliveryAddress: String
    let status: String
}
