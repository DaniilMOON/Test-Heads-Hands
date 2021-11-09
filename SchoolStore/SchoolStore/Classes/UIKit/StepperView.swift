// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

// MARK: - StepperViewProtocol

protocol StepperViewProtocol: AnyObject {
    var text: String { get set }
    var minusButton: UIButton { get }
    var plusButton: UIButton { get }
}

// MARK: - StepperView

final class StepperView: UIView, StepperViewProtocol {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Internal

    var minimun = Int(-INT_MAX)
    var maximum = Int(INT_MAX)
    private(set) lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.keyboardType = .numberPad
        return field
    }()

    internal lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        return button
    }()

    internal lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = -1
        return button
    }()

    @IBInspectable
    var text: String {
        get {
            textField.text ?? String(minimun)
        }
        set {
            textField.text = String(Int(newValue) ?? minimun)
        }
    }

    func check() {
        var newValue = Int(textField.text ?? "") ?? minimun
        if newValue > maximum {
            newValue = maximum
        }
        if newValue < minimun {
            newValue = minimun
        }
        textField.text = String(newValue)
    }

    // MARK: Private

    private let normalColor: UIColor = Asset.fieldText.color.withAlphaComponent(0.87)

    @objc
    private func minusBtn() {
        if Int(text)! - 1 >= minimun {
            textField.text = String(Int(text)! - 1)
        }
    }

    @objc
    private func plusBtn() {
        if Int(text)! + 1 <= maximum {
            textField.text = String(Int(text)! + 1)
        }
    }

    private func setup() {
        addSubview(textField)
        addSubview(minusButton)
        addSubview(plusButton)
        backgroundColor = Asset.grey.color
        layer.cornerRadius = 12

        minusButton
            .width(32)
            .height(28)
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(normalColor, for: .normal)
        minusButton.titleLabel?.textAlignment = .center
        minusButton.layer.cornerRadius = 12
        minusButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        minusButton.addTarget(self, action: #selector(minusBtn), for: .touchUpInside)

        textField
            .left(to: .right, of: minusButton)
            .centerY(to: minusButton)
            .width(50)
            .height(24)
        textField.textColor = normalColor
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = Asset.white.color
        textField.textAlignment = .center

        plusButton
            .left(to: .right, of: textField)
            .width(32)
            .height(as: textField)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(normalColor, for: .normal)
        plusButton.titleLabel?.textAlignment = .center
        plusButton.layer.cornerRadius = 12
        plusButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        plusButton.addTarget(self, action: #selector(plusBtn), for: .touchUpInside)
    }
}
