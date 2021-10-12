// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct AppState {
    var accessToken: String?

    var isUserAuthenticated: Bool {
        !(accessToken ?? "").isEmpty
    }
}
