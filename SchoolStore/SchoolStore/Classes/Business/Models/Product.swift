// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Product: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: CodingKeys.id)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        department = try container.decode(String.self, forKey: CodingKeys.department)
        price = try container.decode(Int.self, forKey: CodingKeys.price)
        badge = try container.decode(ProductBadge.self, forKey: CodingKeys.badge)
        images = try container.decode([String].self, forKey: CodingKeys.images)
        preview = try container.decode(String.self, forKey: CodingKeys.preview)
        sizes = try container.decode([ProductSizes].self, forKey: CodingKeys.sizes)
        description = try container.decode(String.self, forKey: CodingKeys.description)
        details = try container.decode([String].self, forKey: CodingKeys.details)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case id, title, department, price, badge, images, preview, sizes, description, details
    }

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
