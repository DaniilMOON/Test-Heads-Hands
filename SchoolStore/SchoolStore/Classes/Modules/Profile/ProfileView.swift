// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Kingfisher
import UIKit

class ProfileView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Asset.main.color.withAlphaComponent(1)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Internal

    func fillWith(profile: Profile?) {
        guard let profile = profile else {
            return
        }

        if let previewUrl = URL(string: profile.avatarUrl) {
            let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: profile.avatarUrl)
            avatarProfile.kf.setImage(
                with: contentImageResource,
                placeholder: Asset.imagePlaceholder.image,
                options: [
                    .transition(.fade(0.2)),
                    .forceTransition,
                    .cacheOriginalImage,
                    .keepCurrentImageWhileLoading,
                ]
            )
        } else {
            avatarProfile.image = Asset.imagePlaceholder.image
        }

        nameLabel.text = "\(profile.name) \(profile.surname)"
        specialityLabel.text = profile.occupation
    }

    // MARK: Private

    private lazy var avatarProfile: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var specialityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setup() {
        addSubview(avatarProfile)
        addSubview(nameLabel)
        addSubview(specialityLabel)

        avatarProfile
            .top(0)
            .centerX()
            .height(90)
            .width(90)
        avatarProfile.layer.cornerRadius = 45
        avatarProfile.clipsToBounds = true

        nameLabel
            .top(to: .bottom(16), of: avatarProfile)
            .centerX()
        nameLabel.textColor = Asset.white.color
        nameLabel.font = UIFont(name: "Roboto-Medium", size: 24)

        specialityLabel
            .top(to: .bottom, of: nameLabel)
            .centerX()
            .bottom(16)
        specialityLabel.textColor = Asset.white.color
        specialityLabel.font = UIFont(name: "Roboto-Medium", size: 14)
    }
}
