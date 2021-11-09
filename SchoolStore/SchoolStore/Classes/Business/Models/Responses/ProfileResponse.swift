// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct ProfileResponse: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profile = try container.decode(Profile.self, forKey: CodingKeys.profile)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case profile
    }

    let profile: Profile
}
