// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let message: String
    let fields: [FieldError]?
}
