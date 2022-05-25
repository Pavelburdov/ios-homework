//
//  LogInViewController.swift
//  Navigation
//
//  Created by Pavel on 03.04.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    private lazy var scrollView: UIScrollView = {//создаем скроллвью
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {//создаем скроллвью
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupView()
        tapGesture()
//                self.infoTextField.delegate = self
//                self.passwordTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)//подписываем под уведомления, назначаем метод который будет срабатывать при появлении клавы
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)//подписываем под уведомления, назначаем метод который будет срабатывать при скрытии клавы
    }

    @objc func kbWillShow(notification: Notification) { //метод для того чтобы текстфилды приподнимались при появлении клавиатуры
        if let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue { // стандартная запись для получения значения размеров клавиатуры
            scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height * 0.1)//используем это свойство чтобы сместить скролвью
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        }
    }

    @objc func kbWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero // когда клава исчезает тектстфилды с кнопкой возвращаются на место
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "logo")
        imageLogo.translatesAutoresizingMaskIntoConstraints = false

        return imageLogo
    }()

    private lazy var stackView: UIStackView = { // создаем стек для стека с двумя текстфилдами и кнопкой
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var textFieldStackView: UIStackView = { // создаем стек для двух текстфилдов
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = .lightGray
        textField.placeholder = "Email or phone"
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = .lightGray
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var buttonLogIn: UIButton = { //создаем кнопку
        let button = UIButton()
        button.layer.cornerRadius = 10
        //let image = UIImage(named: "blue_pixel")
        button.backgroundColor = UIColor(named: "Color")
        //button.setBackgroundImage(image, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)

        if button.isSelected {
            button.alpha = 0.8
        } else if button.isHighlighted {
            button.alpha = 0.8
        } else if !button.isEnabled {
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }

        button.addTarget(self, action: #selector(didTapLogButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private func setupView() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(logoImageView)
        self.stackView.addArrangedSubview(textFieldStackView)
        self.stackView.addArrangedSubview(buttonLogIn)
        self.textFieldStackView.addArrangedSubview(infoTextField)
        self.textFieldStackView.addArrangedSubview(passwordTextField)

        NSLayoutConstraint.activate([

            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),

            self.logoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 100),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.logoImageView.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -120),

            self.stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),

            self.infoTextField.heightAnchor.constraint(equalToConstant: 50),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            self.buttonLogIn.heightAnchor.constraint(equalToConstant: 50),

        ])
    }


    @objc func didTapLogButton() { //изменение прозрачности по нажатию на кнопку
        if buttonLogIn.isSelected {
            buttonLogIn.alpha = 0.8
        } else if buttonLogIn.isHighlighted {
            buttonLogIn.alpha = 0.8
        } else if !buttonLogIn.isEnabled {
            buttonLogIn.alpha = 0.8
        } else {
            buttonLogIn.alpha = 1
        }

        let profileVC = ProfileViewController() //переход на другой экран по нажатию на кнопку
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
    extension LogInViewController { // KEYBOARD

        func tapGesture() {
            let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
            self.view.addGestureRecognizer(tapGesture)
        }
    }

