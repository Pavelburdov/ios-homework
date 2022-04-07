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

    private var heightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.setupNavigationBar()
        self.setupView()
        tapGesture()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }

    private lazy var statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private func setupView() {

        self.view.addSubview(self.profileHeaderView)
        self.view.addSubview(self.statusButton)

        self.profileHeaderView.backgroundColor = .lightGray

        let topAnchor = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)


        let leadingAnchorBottonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchorBottonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchorBottonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let heightStatusButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)


        NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, self.heightConstraint, leadingAnchorBottonConstraint, trailingAnchorBottonConstraint, bottomAnchorBottonConstraint, heightStatusButtonConstraint].compactMap({$0}))
    }

    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func didTapMyButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 250 : 220

        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

