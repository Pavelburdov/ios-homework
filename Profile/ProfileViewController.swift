//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }

    private var heightAnchorConstraint: NSLayoutConstraint?

    override func viewWillLayoutSubviews() {
        self.view.addSubview(self.profileHeaderView)
        self.view.addSubview(self.statusButton)
        self.profileHeaderView.backgroundColor = .lightGray
        let topAnchor = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.heightAnchorConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)


        let leadingAnchorBottonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchorBottonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchorBottonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)

        NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, self.heightAnchorConstraint, leadingAnchorBottonConstraint, trailingAnchorBottonConstraint, bottomAnchorBottonConstraint].compactMap({$0}))
    }
}
