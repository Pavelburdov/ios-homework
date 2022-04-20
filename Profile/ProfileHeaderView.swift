//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    
    func didTapMyButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private lazy var avatarImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cat")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = { // создаем стэк для меток
        let stackLabelView = UIStackView() //создаем стэк
        stackLabelView.translatesAutoresizingMaskIntoConstraints = false //отключаем AutoresizingMask
        stackLabelView.axis = .vertical //вертикальный стэк
        stackLabelView.spacing = 40
        stackLabelView.distribution = .fillEqually // на весь вью стэка
        
        return stackLabelView
    }()
    
    private lazy var infoStackView: UIStackView = { // создаем стэк для меток
        let stackView = UIStackView() //создаем стэк
        stackView.axis = .horizontal // горизрнтальный стэк
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false //отключаем AutoresizingMask
        
        return stackView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Cat"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18.0)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Hunting"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //создаем свойство textField
    private lazy var statusTextField: UITextField = { // Устанавливаем текстовое поле
        let textField = UITextField()
        textField.placeholder = "Введите статус"
        textField.backgroundColor = .white // цвет поля
        textField.font = UIFont.systemFont(ofSize: 15)  // Шрифт и размеры
        textField.textColor = .black // цвет текста
        textField.layer.cornerRadius = 12.0  // делаем скругление
        textField.layer.borderWidth = 1.0 // делаем рамку-обводку
        textField.layer.borderColor = UIColor.black.cgColor // устанавливаем цвет рамке
        //textField.textAlignment = .center // расположение текста
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0)) // Отступ слева
        textField.leftView = leftView // добавляем отступ
        textField.leftViewMode = .always //всегда слева
        //        textField.clipsToBounds = true  // устанавливаем вид в границах рамки
        textField.translatesAutoresizingMaskIntoConstraints = false// отключаем констрейты
        
        return textField
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        // button.setTitle("Show status", for: .normal)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.didTapMyButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    private var buttonTopConstraint: NSLayoutConstraint? //изменение верхнего констрейта кнопки

    weak var delegate: ProfileHeaderViewProtocol?
    
    private func drawSelf() {
        self.addSubview(infoStackView)
        self.addSubview(statusTextField)
        self.addSubview(statusButton)
        self.infoStackView.addArrangedSubview(avatarImageView)
        self.infoStackView.addArrangedSubview(labelsStackView)
        self.labelsStackView.addArrangedSubview(fullNameLabel)
        self.labelsStackView.addArrangedSubview(statusLabel)
        self.statusTextField.delegate = self
        
        

        let stackViewTopConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let stackViewLeadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let stackViewTrailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        let avatarImageViewWidthConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 138)
        let avatarImageViewHeightConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 138)

        let buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        let buttonLeadingConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let buttonTrailingConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let buttonHeightConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        let buttonBottomConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)

        let topTextFieldConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: -10)
        let leadingTextFieldConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.labelsStackView.leadingAnchor)
        let heightTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        let trailingTextFieldConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.labelsStackView.trailingAnchor)

        NSLayoutConstraint.activate([ stackViewTopConstraint, stackViewLeadingConstraint, stackViewTrailingConstraint, avatarImageViewWidthConstraint, buttonTopConstraint, buttonLeadingConstraint, buttonTrailingConstraint, avatarImageViewHeightConstraint, buttonHeightConstraint, buttonBottomConstraint, topTextFieldConstraint, leadingTextFieldConstraint, heightTextFieldConstraint, trailingTextFieldConstraint
                                    ])
    }
    
    private var statusText: String? = nil //приватная опциональная переменная с типом String
    
    func textFieldShouldReturn(_ statusTextField: UITextField) -> Bool { //метод закрытия клавиатуры
        self.endEditing(true)
        return false
    }
    
    @objc func didTapMyButton(){

        guard statusTextField.text != "" else {
            statusTextField.backgroundColor = .systemRed
            statusTextField.shake()
            return
        }

        statusText = statusTextField.text!
        statusLabel.text = "\(statusText ?? "")"
        self.statusTextField.text = nil
        self.endEditing(true)
    }
}
