// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum CatalogRequest: Request {
    case listOfProducts(offset: Int, limit: Int)
    case detailInfo(String)

    // MARK: Internal

    var path: String {
        switch self {
        case .listOfProducts:
            return "products"
        case let .detailInfo(productId):
            return "products/\(productId)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .listOfProducts, .detailInfo:
            return .get
        }
    }

    var mock: Data? {
        switch self {
        case let .listOfProducts(offset, _):
            if offset == 0 {
                guard let path = Bundle.main.path(forResource: "listOfProducts1", ofType: "json"),
                      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                else {
                    return nil
                }
                return data

            } else if 12 ... 24 ~= offset {
                guard let path = Bundle.main.path(forResource: "listOfProducts2", ofType: "json"),
                      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                else {
                    return nil
                }
                return data

            } else {
                guard let path = Bundle.main.path(forResource: "listOfProducts3", ofType: "json"),
                      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                else {
                    return nil
                }
                return data
            }
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
