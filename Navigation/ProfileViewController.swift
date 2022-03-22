//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.setupNavigationBar()

    }
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Профиль"
    }
}
