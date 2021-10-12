// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct AuthResponse: Decodable {
    let accessToken: String
    let profile: Profile
}
