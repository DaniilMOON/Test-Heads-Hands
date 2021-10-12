// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum OrdersRequest: Request {
    case arrangeOrder(productId: String, size: String, quantity: String, house: String, apartment: String, etd: String)
    case listOfOrders
    case cancel

    // MARK: Internal

    var path: String {
        switch self {
        case .arrangeOrder:
            return "orders/checkout"
        case .listOfOrders:
            return "orders"
        case .cancel:
            return "orders/{order_id}/cancel"
        }
    }

    var method: RequestMethod {
        switch self {
        case .arrangeOrder:
            return .post
        case .listOfOrders:
            return .get
        case .cancel:
            return .put
        }
    }

    var body: Data? {
        switch self {
        case let .arrangeOrder(productId, size, quantity, house, apartment, etd):
            return RequestBuilderImpl
                .encode(["produtId": productId, "size": size, "quantity": quantity, "house": house, "apartment": apartment, "etd": etd])
        default:
            return nil
        }
    }

    var mock: Data? {
        switch self {
        case .arrangeOrder:
            guard let path = Bundle.main.path(forResource: "arrangeOrder", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .listOfOrders:
            guard let path = Bundle.main.path(forResource: "listOfOrders", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .cancel:
            guard let path = Bundle.main.path(forResource: "cancelOrder", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        }
    }
}
