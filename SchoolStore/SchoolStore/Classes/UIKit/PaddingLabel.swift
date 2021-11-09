// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PaddingLabel: UILabel {
    // MARK: Open

    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(
            top: -textEdgeInsets.top,
            left: -textEdgeInsets.left,
            bottom: -textEdgeInsets.bottom,
            right: -textEdgeInsets.right
        )
        return textRect.inset(by: invertedInsets)
    }

    // MARK: Internal

    var textEdgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    @IBInspectable
    var paddingLeft: CGFloat {
        set { textEdgeInsets.left = newValue }
        get { textEdgeInsets.left }
    }

    @IBInspectable
    var paddingRight: CGFloat {
        set { textEdgeInsets.right = newValue }
        get { textEdgeInsets.right }
    }

    @IBInspectable
    var paddingTop: CGFloat {
        set { textEdgeInsets.top = newValue }
        get { textEdgeInsets.top }
    }

    @IBInspectable
    var paddingBottom: CGFloat {
        set { textEdgeInsets.bottom = newValue }
        get { textEdgeInsets.bottom }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
}
