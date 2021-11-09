// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Kingfisher
import UIKit

// MARK: - OrderFormProtocol

protocol OrderFormProtocol: AnyObject {
    var buyButton: UIButton { get }
    var addressInputField: InputField { get set }
    var flatNumberInputField: InputField { get set }
    var dateInputField: InputField { get set }
    var stepperView: StepperView { get set }
}

// MARK: - OrderFormView

class OrderFormView: UIView, OrderFormProtocol {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        hideKeyboard()
        translatesAutoresizingMaskIntoConstraints = false
        setup()
        createDatePicker()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hideKeyboard()
        setup()
        createDatePicker()
    }

    // MARK: Internal

    internal lazy var buyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Asset.main.color
        button.setTitle(L10n.OrderForm.buyNow, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()

    internal lazy var addressInputField: InputField = {
        let field = InputField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.title = L10n.OrderForm.address
        return field
    }()

    internal lazy var flatNumberInputField: InputField = {
        let field = InputField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.title = L10n.OrderForm.flatNumber
        return field
    }()

    internal lazy var dateInputField: InputField = {
        let field = InputField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.title = L10n.OrderForm.deliveryDate
        return field
    }()

    internal lazy var stepperView: StepperView = {
        let sv = StepperView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.text = "1"
        sv.minimun = 1
        sv.maximum = 999
        sv.textField.addTarget(self, action: #selector(stepperTextDidChage), for: .editingChanged)
        sv.minusButton.addTarget(self, action: #selector(stepperTextDidChage), for: .touchUpInside)
        sv.plusButton.addTarget(self, action: #selector(stepperTextDidChage), for: .touchUpInside)
        return sv
    }()

    func fillWith(product: Product?) {
        guard let product = product else {
            return
        }
        self.product = product
        price = product.price
        editCountPrice()

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

    private var product: Product?
    private var price: Int? = 0
    private let textPrimaryColor: UIColor = Asset.textPrimary.color
    private let textSecondaryColor: UIColor = Asset.textSecondary.color

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

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

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    @objc
    private func stepperTextDidChage() {
        stepperView.check()
        editCountPrice()
    }

    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)
    }

    @objc
    private func dismissKeyboard() {
        scrollView.endEditing(true)
    }

    private func editCountPrice() {
        let count = Int(stepperView.text) ?? 0
        let strPrice = NumberFormatter.rubString(from: price! * count)
        buyButton.setTitle("\(L10n.OrderForm.buyNow) \(strPrice)", for: .normal)
    }

    @objc
    private func doneAction() {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        dateInputField.text = dateFormatter.string(from: datePicker.date)
    }

    private func createDatePicker() {
        guard let date = dateInputField.text else { return }
        if date.isEmpty {
            doneAction()
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateInputField.textField.inputView = datePicker

        let calendar = Calendar(identifier: .gregorian)
        let comps = DateComponents()
        let minDate = calendar.date(byAdding: comps, to: Date())
        datePicker.minimumDate = minDate

        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(doneAction), for: .valueChanged)

        let toolbar: UIToolbar = {
            let toolbar = UIToolbar()
            toolbar.translatesAutoresizingMaskIntoConstraints = false
            return toolbar
        }()
        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        toolbar.setItems([flexSpace, doneButton], animated: true)
//        dateInputField.textField.inputAccessoryView = toolbar
    }

    private func setup() {
        addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(previewImageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(departmentLabel)
        mainView.addSubview(stepperView)
        mainView.addSubview(addressInputField)
        mainView.addSubview(flatNumberInputField)
        mainView.addSubview(dateInputField)
        addSubview(buyButton)

        scrollView.top().left().right().bottom()
        mainView.top().left().right().bottom().width(as: scrollView)

        previewImageView.top(16).left(16).height(112).width(112)

        titleLabel.textColor = textPrimaryColor
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.top(to: .top, of: previewImageView).left(to: .right(16), of: previewImageView).right(16)

        departmentLabel.textColor = textSecondaryColor
        departmentLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        departmentLabel.top(to: .bottom, of: titleLabel).left(to: .right(16), of: previewImageView).right(16)

        // steperView.backgroundColor = .red
        stepperView.bottom(to: .bottom(0), of: previewImageView).right(16).height(28).width(32 + 50 + 32)

        addressInputField.top(to: .bottom(48), of: previewImageView).left(16).right(16)

        flatNumberInputField.top(to: .bottom(32), of: addressInputField).left(16).right(16)

        dateInputField.top(to: .bottom(32), of: flatNumberInputField).left(16).right(16).bottom()

        buyButton.left(16).right(16).bottom().height(44)
    }
}
