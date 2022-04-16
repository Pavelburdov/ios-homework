//
//  GesturesViewController.swift
//  Navigation
//
//  Created by Pavel on 13.04.2022.
//

import UIKit

class GesturesViewController: UIViewController {

    private lazy var avatarImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cat")
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    // создаю вторую вью
    private lazy var secondImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.alpha = 0 //прозрачна
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    //создаю копку
    private lazy var myButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "multiply")
        button.setBackgroundImage(image, for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let tapGestureRecognizer = UITapGestureRecognizer() // создаю дискретный распознаватель жестов (1 или несколько касаний)
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    private var isExpanded = false // свойство расширения для вью

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.avatarImageView)
        self.view.addSubview(self.secondImageView)
        self.view.addSubview(self.myButton)

        self.topConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        self.leadingConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        self.widthConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 140)
        self.heightConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 140)

        let centrXConstraint = self.secondImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centrYConstraint = self.secondImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let widthConstraint = self.secondImageView.widthAnchor.constraint(equalToConstant: 250)
        let heightConstraint = self.secondImageView.heightAnchor.constraint(equalToConstant: 250)

        let topButtonConstraint = self.myButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 242)
        let trailingButtonConstraint = self.myButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let widthButtonConstraint = self.myButton.widthAnchor.constraint(equalToConstant: 50)
        let heightButtonConstraint = self.myButton.heightAnchor.constraint(equalToConstant: 50)


        NSLayoutConstraint.activate([
            self.topConstraint, self.leadingConstraint, self.widthConstraint, self.heightConstraint, centrXConstraint, centrYConstraint, widthConstraint, heightConstraint, topButtonConstraint, trailingButtonConstraint, widthButtonConstraint, heightButtonConstraint].compactMap({$0}))

    }
    // метод для обработки касания
    private func setupGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:))) // распознает какой метод будет срабатывать
        self.avatarImageView.addGestureRecognizer(self.tapGestureRecognizer) // avatarImageView теперь может обрабатывать касание tapGestureRecognizer
        myButton.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    }
    // метод действия с картинкой
    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        self.secondImageView.isHidden = false // появится вторая вью
        self.myButton.isHidden = false // появится кнопка
        self.isExpanded.toggle() //нажатие
        self.heightConstraint?.constant = self.isExpanded ? self.view.bounds.height : 140 //увеличение до размеров вью
        self.widthConstraint?.constant = self.isExpanded ? self.view.bounds.width : 140
        NSLayoutConstraint.deactivate( [self.topConstraint, self.leadingConstraint].compactMap({$0})) //деактивируем констрейнты чтобы картинка была по центру
        // настройка анимации
        UIView.animate(withDuration: 0.5) { // анимация 0.5 сек
            self.secondImageView.alpha = self.isExpanded ? 0.5 : 0 //по нажатию становится полупрозрачной
            self.view.layoutIfNeeded()

        } completion: { _ in
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) { //анимация длится 0.3 сек с задержкой 0.5
            self.myButton.alpha = self.isExpanded ? 1 : 0 //изменяется прозрачность кнопки
            self.view.layoutIfNeeded()

        } completion: { _ in
        }

    }

    @objc private func didTapButton() {
        self.secondImageView.isHidden = false // появится вторая вью
        self.myButton.isHidden = false // появится кнопка
        self.isExpanded.toggle() //нажатие
        self.heightConstraint?.constant = self.isExpanded ? self.view.bounds.height : 140 //увеличение до размеров вью
        self.widthConstraint?.constant = self.isExpanded ? self.view.bounds.width : 140
        NSLayoutConstraint.activate( [self.topConstraint, self.leadingConstraint].compactMap({$0})) //деактивируем констрейнты чтобы картинка была по центру
        // настройка анимации
        UIView.animate(withDuration: 0.5) { // анимация 0.5 сек
            self.secondImageView.alpha = self.isExpanded ? 0.5 : 0 //по нажатию становится полупрозрачной
            self.view.layoutIfNeeded()
        } completion: { _ in
        }

        UIView.animate(withDuration: 0.2) { //анимация длится 0.2 сек 
            self.myButton.alpha = self.isExpanded ? 1 : 0 //изменяется прозрачность кнопки
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
    }
}
