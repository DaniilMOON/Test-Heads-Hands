// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct DataResponse<T: Decodable>: Decodable {
    let data: T
}
