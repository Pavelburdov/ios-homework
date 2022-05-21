//
//  InfoViewController.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

class InfoViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(alertButton)
        self.setupAlertButton()

        // Do any additional setup after loading the view.
    }

    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("Показать аллерт", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

   private func setupAlertButton() {
        alertButton.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
        self.alertButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.alertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc private func didTapAlertButton() {
        let alert = UIAlertController(title: "Внимание", message: "Вы уверены", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "ДА", style: .default, handler: {action in print ("ДА")})
        let noButton = UIAlertAction(title: "НЕТ", style: .default, handler: {action in print("НЕТ")})
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert, animated: true, completion: nil)
    }
}
