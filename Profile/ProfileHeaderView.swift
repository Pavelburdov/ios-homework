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
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70
        imageView.contentMode = .scaleToFill
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
        textField.isHidden = true // текстовое поле спрятано
        textField.backgroundColor = .white // цвет поля
        textField.font = UIFont.systemFont(ofSize: 15)  // Шрифт и размеры
        textField.textColor = .black // цвет текста
        textField.layer.cornerRadius = 12.0  // делаем скругление
        textField.layer.borderWidth = 1.0 // делаем рамку-обводку
        textField.layer.borderColor = UIColor.black.cgColor // устанавливаем цвет рамке
        textField.textAlignment = .center // расположение текста
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
        button.setTitle("Show status", for: .normal)
        button.setTitle("Set status", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(didTapMyButton), for: .touchUpInside)
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

    private var buttonTopConstraint: NSLayoutConstraint? //изменение верхнего констрейта кнопки

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


        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16) //вверх
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16) //слева
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16) //справа

        let avatarImageViewRatioConstraint =
        self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0) // аватар 1 к 1  в стэке
        //констрейнты кнопки
        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16) //вверх
        //когда constraint меняется в runtime его приоритет нужно менять
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)

        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16) //слева
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16) //справа
        let bottomButtonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor) // книзу
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50) // высота

        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, avatarImageViewRatioConstraint, self.buttonTopConstraint, leadingButtonConstraint,trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint].compactMap({$0}))
    }

    private var statusText: String? = nil //приватная опциональная переменная с типом String

    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //метод закрытия клавиатуры
        self.endEditing(true)
        return false
    }

    @objc func didTapMyButton(){
        let topTextFieldConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
        let leadingTextFieldConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.labelsStackView.leadingAnchor)
        let heightTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 34)
        let trailingTextFieldConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)

        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)

        if self.statusTextField.isHidden {

            self.addSubview(self.statusTextField)
            statusTextField.text = nil
            statusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstraint?.isActive = false
            NSLayoutConstraint.activate([topTextFieldConstraint, leadingTextFieldConstraint, trailingTextFieldConstraint, heightTextFieldConstraint, buttonTopConstraint].compactMap( {$0} ))

            statusTextField.becomeFirstResponder()

        } else {
            statusText = statusTextField.text!
            statusLabel.text = "\(statusText ?? "")"
            statusButton.setTitle("Show status", for: .normal)

            self.statusTextField.removeFromSuperview()
            NSLayoutConstraint.deactivate([ topTextFieldConstraint, leadingTextFieldConstraint, trailingTextFieldConstraint, heightTextFieldConstraint])
        }

        self.delegate?.didTapMyButton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }
}

