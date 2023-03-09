//
//  FeedViewController.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

struct Post {
    var title: String
}

let titlePost = Post.init(title: "Мой пост")

class FeedViewController: UIViewController {
    //Создаем кнопку
    private lazy var firstButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var buttonsStackView: UIStackView = { // создаем стэк для меток
        let stackView = UIStackView() //создаем стэк
        stackView.translatesAutoresizingMaskIntoConstraints = false //отключаем AutoresizingMask
        stackView.axis = .vertical //вертикальный стэк
        stackView.spacing = 10
        stackView.distribution = .fillEqually // на весь вью стэка

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Добавляем кнопку "Перейти на пост"
        self.view.addSubview(buttonsStackView)
        self.buttonsStackView.addArrangedSubview(firstButton)
        self.buttonsStackView.addArrangedSubview(secondButton)
        self.setupButton()

    }
    //Настройка анимации заголовка "Лента"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
    }
//настройка кнопки (констреймы, действие...)
    private func setupButton() {
        let firstStackViewConstraint = buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let secondStackViewConstraint = buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let leadingFirstButtonConstraint = self.firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let trailingFirstButtonConstraint = self.firstButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        let leadingSecondButtonConstraint = self.secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let trailingSecondButtonConstraint = self.secondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)

        NSLayoutConstraint.activate([firstStackViewConstraint, secondStackViewConstraint, leadingFirstButtonConstraint, trailingFirstButtonConstraint, leadingSecondButtonConstraint, trailingSecondButtonConstraint])
    }
    // переход на PostViewController
        @objc func didTapTransitionButton() {
            let postVC = PostViewController()
            postVC.navigationItem.title = titlePost.title
            self.navigationController?.pushViewController(postVC, animated: true)

}
}
