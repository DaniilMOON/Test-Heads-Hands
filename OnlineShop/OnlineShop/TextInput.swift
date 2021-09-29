//
//  TextInput.swift
//  Test3
//
//  Created by Даниил Осипов on 27.09.2021.
//

import UIKit

class TextInput: UIView {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var contentView: UIView?
    
    var text: String?
    var error: String?
    
    var isSecure: Bool?
    var iconClick: Bool = false
    let imageIcon = UIImageView()
    
    func setText(textAdd: String) {
        textField.placeholder = textAdd
        labelText.text = textAdd
        text = textAdd
    }
    
    func getTextInTextField() -> String? {
        return textField.text
    }
    
    func setError(errorAdd: String) {
        error = errorAdd
        errorTextLabel.text = error
        if (error != "") {
            errorView.isHidden = false
            errorTextLabel.isHidden = false
            labelText.textColor = .red
        } else {
            errorView.isHidden = true
            errorTextLabel.isHidden = true
            labelText.textColor = .darkGray
        }
    }
    
    func setIsSecure(isSecureAdd: Bool) {
        if isSecureAdd {
            iconClick = isSecureAdd
            textField.isSecureTextEntry = iconClick
            addIcon()
        }
        isSecure = isSecureAdd
    }
    
    private func addIcon() {
        imageIcon.image = UIImage(systemName: "eye")
        let width = imageIcon.image!.size.width, height = imageIcon.image!.size.height
        let cView = UIView()
        cView.addSubview(imageIcon)
        
        cView.frame =  CGRect(x: 0, y: 0, width: width, height: height)
        imageIcon.frame =  CGRect(x: 0, y: -3, width: width, height: height)
        textField.rightView = cView
        textField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(iconTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func iconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick{
            iconClick = !iconClick
            tappedImage.image = UIImage(systemName: "eye.slash")
            textField.isSecureTextEntry = iconClick
        } else {
            iconClick = !iconClick
            tappedImage.image = UIImage(systemName: "eye")
            textField.isSecureTextEntry = iconClick
        }
    }
    
    func getText() -> String? {
        return text
    }
    
    func getError() -> String? {
        return error
    }
    
    private func setup() {
        guard let view = loadFromNib() else {
            return
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 8
        contentView = view
        
        labelText.isHidden = true
        errorView.isHidden = true
        errorTextLabel.isHidden = true
        
        textField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingEnded(_:)), for: .editingDidEnd)
    }
    
    @objc func editingBegan(_ textField: UITextField) {
        //user entered the field
        
        labelText.isHidden = false
        textField.placeholder = ""
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        //the text has changed
    }
    
    @objc func editingEnded(_ textField: UITextField) {
        //input completed
        if let textInTextField = textField.text {
            if textInTextField.count == 0 {
                labelText.isHidden = true
                textField.placeholder = text
            }
        }
    }
    
    private func loadFromNib() -> UIView? {
        let view = Bundle.main.loadNibNamed("TextInput", owner: self, options: nil)?.first as? UIView
        return view
    }
}
