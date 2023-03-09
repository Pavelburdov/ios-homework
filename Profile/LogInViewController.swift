//
//  LogInViewController.swift
//  Navigation
//
//  Created by Pavel on 03.04.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    let user = User(emailRegEx: "b@b.ru", passwordReg: "123456") // ЛОГИН и ПАРОЛЬ

    private lazy var scrollView: UIScrollView = {//создаем скроллвью
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.setupView()
        self.tapGesture()
        self.infoTextField.delegate = self
        self.passwordTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)//подписываем под уведомления, назначаем метод который будет срабатывать при появлении клавы
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)//подписываем под уведомления, назначаем метод который будет срабатывать при скрытии клавы
    }

    @objc func kbWillShow(notification: Notification) { //метод для того чтобы текстфилды приподнимались при появлении клавиатуры
        if let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue { // стандартная запись для получения значения размеров клавиатуры
            scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height * 0.1 )//используем это свойство чтобы сместить скролвью
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
    // лейбл для текстового предупреждения
    private lazy var warningLabel: UILabel = {
        let labelCount = UILabel()
        labelCount.numberOfLines = 0
        labelCount.translatesAutoresizingMaskIntoConstraints = false

        return labelCount
    }()

    private lazy var buttonLogIn: UIButton = { //создаем кнопку
        let button = UIButton()
        button.layer.cornerRadius = 10
        let image = UIImage(named: "blue_pixel")
        button.backgroundColor = UIColor(named: "Color")
        button.setBackgroundImage(image, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
// изменение прозрачности кнопки по нажатию
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
        self.scrollView.addSubview(stackView)
        self.scrollView.addSubview(logoImageView)
        self.stackView.addArrangedSubview(textFieldStackView)
        self.stackView.addArrangedSubview(buttonLogIn)
        self.textFieldStackView.addArrangedSubview(infoTextField)
        self.textFieldStackView.addArrangedSubview(passwordTextField)
        self.view.addSubview(warningLabel)

        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewLeadingConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        let scrollViewTrailingConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        let bottomLogoConstraint = self.logoImageView.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -120)
        let widthLogoConstraint = self.logoImageView.widthAnchor.constraint(equalToConstant: 100)
        let heightLogoConstraint = self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        let centrXLogoConstraint = self.logoImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)

        let stackViewCentrXConstraint = self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let stackViewCentrYConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let stackViewLeadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let stackViewTrailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)

        let heightInfoTextField = self.infoTextField.heightAnchor.constraint(equalToConstant: 50)
        let heightPasswordTextField = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        let heightButtonLogIn = self.buttonLogIn.heightAnchor.constraint(equalToConstant: 50)

        let bottomConstrain = self.warningLabel.bottomAnchor.constraint(equalTo: self.infoTextField.topAnchor, constant: -16)
        let rightConstraint = self.warningLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        let leftConstraint = self.warningLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)

        NSLayoutConstraint.activate([scrollViewTopConstraint, scrollViewLeadingConstraint, scrollViewTrailingConstraint, scrollViewBottomConstraint, bottomLogoConstraint, widthLogoConstraint, heightLogoConstraint, centrXLogoConstraint, stackViewCentrXConstraint, stackViewCentrYConstraint, stackViewLeadingConstraint, stackViewTrailingConstraint, heightInfoTextField, heightPasswordTextField, heightButtonLogIn, bottomConstrain, rightConstraint, leftConstraint].compactMap({$0}))
    }

    private func tapGesture() { //метод скрытия клавиатуры по нажатию на экран
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }

    // метод переключения лейбла, валидин пароль или нет
    private func checkValidation(inputString: UITextField, givenString: String) {
        guard inputString.text!.count < givenString.count - 1 ||
                inputString.text!.count > givenString.count - 1 else {
            warningLabel.text = ""

            return
        }

        warningLabel.textColor = .red
        warningLabel.text = "\(String(describing: inputString.placeholder!)) содержит \(givenString.count) символов"
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // ПРОВЕРКА КОЛИЧЕСВА ВВЕДЕННЫХ СИМВОЛОВ
        let text = (textField.text ?? "") + string
        // убираем последний индекс в строке
        let result: String

        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1) //последний символ будет на единицу меньше чем наша строка
            result = String(text[text.startIndex..<end])
            //иначе пользуемся готовой строкой которую мы получили в тексте
        } else {
            result = text
        }

        if textField == infoTextField {
            checkValidation(inputString: infoTextField, givenString: user.emailRegEx)
        } else {
            checkValidation(inputString: passwordTextField, givenString: user.passwordReg)
        }
        textField.text = result
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // СПРЯТАТЬ КЛАВИАТУРУ ПО RETURN
        self.view.endEditing(true)
        return false
    }
}


extension LogInViewController { // LOGIN AND PASSWORD VERIFICATION

    private func isEmpty(textField: UITextField) -> Bool { // ПОТРЯХИВАНИЕ ПУСТОГО TEXTFIELD
        guard textField.text != "" else {
            textField.shake()

            return false
        }

        return true
    }

    private func validationEmail(textField: UITextField) -> Bool { // ПРОВЕРКА ЛОГИНА

        guard textField.text!.isValidEmail, textField.text == user.emailRegEx else {
            openAlert(title: "ОШИБКА",
                      message: "Некорректный ввод адреса электронной почты",
                      alertStyle: .alert, actionTitles: ["Повторить"],
                      actionStyles: [.default],
                      actions: [{ _ in
                print("ОШИБКА")
            }])
            self.infoTextField.backgroundColor = .systemRed
            return false
        }

        return true
    }

    private func validationPassword(textField: UITextField) -> Bool { // ПРОВЕРКА ПАРОЛЯ

        guard textField.text!.validPassword, textField.text == user.passwordReg else {
            openAlert(title: "ОШИБКА",
                      message: "Некорректный ввод пароля",
                      alertStyle: .alert, actionTitles: ["Повторить"],
                      actionStyles: [.default],
                      actions: [{ _ in
                print("ОШИБКА")
            }])
            self.passwordTextField.backgroundColor = .systemRed
            return false
        }

        return true
    }

    @objc func didTapLogButton() {
        if isEmpty(textField: infoTextField), validationEmail(textField: infoTextField),
           isEmpty(textField: passwordTextField), validationPassword(textField: passwordTextField) {

        let profileVC = ProfileViewController() //переход на другой экран по нажатию на кнопку
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
}
