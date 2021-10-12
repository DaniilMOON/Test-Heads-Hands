// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum CatalogRequest: Request {
    case listOfProducts
    case detailInfo

    // MARK: Internal

    var path: String {
        switch self {
        case .listOfProducts:
            return "products"
        case .detailInfo:
            return "products/{product_id}"
        }
    }

    var method: RequestMethod {
        switch self {
        case .listOfProducts:
            return .get
        case .detailInfo:
            return .get
        }
    }

    var mock: Data? {
        switch self {
        case .listOfProducts:
            guard let path = Bundle.main.path(forResource: "listOfProducts", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .detailInfo:
            guard let path = Bundle.main.path(forResource: "detailsInfo", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        }
    }
}
