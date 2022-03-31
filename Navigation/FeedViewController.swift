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
    private lazy var transitionButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Добавляем кнопку "Перейти на пост"
        self.view.addSubview(transitionButton)
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
        transitionButton.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
            self.transitionButton.bottomAnchor.constraint(equalTo:
                                                            self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.transitionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.transitionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.transitionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    // переход на PostViewController
        @objc func didTapTransitionButton() {
            let postVC = PostViewController()
            postVC.navigationItem.title = titlePost.title
            self.navigationController?.pushViewController(postVC, animated: true)

}
}
