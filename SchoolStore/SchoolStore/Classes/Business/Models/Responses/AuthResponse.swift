// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct AuthResponse: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: CodingKeys.accessToken)
        profile = try container.decode(Profile.self, forKey: CodingKeys.profile)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case accessToken, profile
    }

    let accessToken: String
    let profile: Profile
}
