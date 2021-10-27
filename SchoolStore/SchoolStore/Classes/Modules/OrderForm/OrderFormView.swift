// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Kingfisher
import UIKit

class OrderFormView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
        createDatePicker()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        createDatePicker()
    }

    // MARK: Internal

    func fillWith(product: Product?) {
        guard let product = product else {
            return
        }

        if let previewUrl = URL(string: product.preview) {
            let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: product.preview)
            previewImageView.kf.setImage(
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
            previewImageView.image = Asset.imagePlaceholder.image
        }

        titleLabel.text = product.title
        departmentLabel.text = product.department
    }

    // MARK: Private

    private let textPrimaryColor: UIColor = Asset.textPrimary.color
    private let textSecondaryColor: UIColor = Asset.textSecondary.color

    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var departmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var steperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var addressInputField: InputField = {
        let field = InputField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.title = L10n.OrderForm.address
        return field
    }()

    private lazy var flatNumberInputField: InputField = {
        let field = InputField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.title = L10n.OrderForm.flatNumber
        return field
    }()

    private lazy var dateInputField: InputField = {
        let field = InputField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.title = L10n.OrderForm.deliveryDate
        return field
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    @objc
    private func doneAction() {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        dateInputField.text = dateFormatter.string(from: datePicker.date)
        endEditing(true)
    }

    private func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateInputField.textField.inputView = datePicker

        let toolbar: UIToolbar = {
            let toolbar = UIToolbar()
            toolbar.translatesAutoresizingMaskIntoConstraints = false
            return toolbar
        }()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        dateInputField.textField.inputAccessoryView = toolbar
    }

    private func setup() {
        addSubview(previewImageView)
        addSubview(titleLabel)
        addSubview(departmentLabel)
        addSubview(steperView)
        addSubview(addressInputField)
        addSubview(flatNumberInputField)
        addSubview(dateInputField)

        previewImageView.top(16).left(16).height(112).width(112)

        titleLabel.textColor = textPrimaryColor
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.top(to: .top, of: previewImageView).left(to: .right(16), of: previewImageView).right(16)

        departmentLabel.textColor = textSecondaryColor
        departmentLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        departmentLabel.top(to: .bottom, of: titleLabel).left(to: .right(16), of: previewImageView).right(16)

        steperView.backgroundColor = .red
        steperView.bottom(to: .bottom(0), of: previewImageView).right(16).height(28).width(48 + 28 + 28)

        addressInputField.top(to: .bottom(48), of: previewImageView).left(16).right(16)

        flatNumberInputField.top(to: .bottom(32), of: addressInputField).left(16).right(16)

        dateInputField.top(to: .bottom(32), of: flatNumberInputField).left(16).right(16).bottom(60)
    }
}
