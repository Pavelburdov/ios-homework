//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.setupNavigationBar()
        self.viewWillLayoutSubviews()

    }
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }

    override func viewWillLayoutSubviews() {
        self.view.addSubview(self.profileHeaderView)
        self.profileHeaderView.backgroundColor = .lightGray
        let topAnchor = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingAnchor = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        let heightAnchor = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 455)
        NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, heightAnchor])
    }
}
