////
////  GesturePhotoViewController.swift
////  Navigation
////
////  Created by Pavel on 16.04.2022.
////
//
//import UIKit
//
//class GesturePhotoViewController: UIViewController {
//
//    struct ViewModel: ViewModelProtocol {
//        var image: String
//    }
//
//    private lazy var avatarImageView: UIImageView = {
//
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .red
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        return imageView
//    }()
//
//    private var centrXConstraint: NSLayoutConstraint?
//    private var centrYConstraint: NSLayoutConstraint?
//    private var widthConstraint: NSLayoutConstraint?
//    private var heightConstraint: NSLayoutConstraint?
//
//    //создаю копку
//    private lazy var myButton: UIButton = {
//        let button = UIButton()
//        let image = UIImage(systemName: "multiply")
//        button.setBackgroundImage(image, for: .normal)
//        button.isHidden = true
//        button.alpha = 0
//        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        return button
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .black.withAlphaComponent(0.0)
//        setupSubView()
//        self.view.layoutIfNeeded()
//        setupGesture()
//        
//
//    }
//
//    private func setupSubView() {
//        self.view.addSubview(avatarImageView)
//        self.view.addSubview(myButton)
//
//        self.widthConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 140)
//        self.heightConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 140)
//        self.centrXConstraint = self.avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        self.centrYConstraint = self.avatarImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//
//        let topButtonConstraint = self.myButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
//        let trailingButtonConstraint = self.myButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
//        let widthButtonConstraint = self.myButton.widthAnchor.constraint(equalToConstant: 40)
//        let heightButtonConstraint = self.myButton.heightAnchor.constraint(equalToConstant: 40)
//
//        NSLayoutConstraint.activate([self.centrXConstraint, self.centrYConstraint, self.widthConstraint, self.heightConstraint, topButtonConstraint, trailingButtonConstraint, widthButtonConstraint, heightButtonConstraint].compactMap({$0}))
//
//    }
//
//    func setupGesture() {
//         NSLayoutConstraint.deactivate([
//            self.centrXConstraint, self.centrYConstraint, self.widthConstraint, self.heightConstraint
//         ].compactMap( {$0} ))
//
//         self.widthConstraint = self.avatarImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
//         self.heightConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
//         self.centrXConstraint = self.avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//         self.centrYConstraint = self.avatarImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//
//         NSLayoutConstraint.activate([
//            self.centrXConstraint, self.centrYConstraint, self.widthConstraint, self.heightConstraint
//         ].compactMap( {$0} ))
//         self.avatarImageView.layer.cornerRadius = 0.0
//         self.view.backgroundColor = .black.withAlphaComponent(0.8)
//
//         UIView.animate(withDuration: 1, animations: {
//             self.view.layoutIfNeeded()
//         }) { _ in
//             UIView.animate(withDuration: 0.25) {
//             self.myButton.alpha = 1
//             }
//         }
//     }
//
//     func moveOut() {
//         NSLayoutConstraint.deactivate([
//            self.centrXConstraint, self.centrYConstraint, self.widthConstraint, self.heightConstraint
//         ].compactMap( {$0} ))
//
//         self.widthConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 140)
//         self.heightConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 140)
//         self.centrXConstraint = self.avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//         self.centrYConstraint = self.avatarImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//
//         NSLayoutConstraint.activate([
//            self.centrXConstraint, self.centrYConstraint, self.widthConstraint, self.heightConstraint
//         ].compactMap( {$0} ))
//         self.avatarImageView.layer.cornerRadius = 70.0
//         self.view.backgroundColor = .black.withAlphaComponent(0.8)
//         self.myButton.alpha = 0.0
//
//         UIView.animate(withDuration: 1, animations: {
//             self.view.layoutIfNeeded()
//         }) { _ in
//             self.view.removeFromSuperview()
//             self.tabBarController?.tabBar.isHidden = false
//             self.navigationController?.navigationBar.isHidden = false
//         }
//     }
//
//       @objc private func clickButton() {
//           moveOut()
//       }
// }
//
//extension GesturePhotoViewController: Setupable { // МОДЕЛЬ
//
//    func setup(with viewModel: ViewModelProtocol) {
//        guard let viewModel = viewModel as? ViewModel else { return }
//        self.avatarImageView.image = UIImage(named: viewModel.image)
//    }
//}
