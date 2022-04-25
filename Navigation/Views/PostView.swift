//
//  PostView.swift
//  Navigation
//
//  Created by Pavel on 14.04.2022.
//

import UIKit

class PostView: UIView {

    struct ViewModel: ViewModelProtocol {
        let author, description, image: String
        var likes: Int
        var views: Int
    }
    private lazy var mainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()

    private lazy var authorLabel: UILabel = { //заголовок
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var postImageView: UIImageView = { //фото
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy  var descriptionLabel: UILabel = { //статья
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var stackView: UIStackView = { //стек для лейблов
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var likesLabel: UILabel = { // ЛАЙКИ
        let label = UILabel()
        label.text = "Likes: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(500), for: .horizontal)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var viewsLabel: UILabel = { // ПРОСМОТРЫ
        let label = UILabel()
        label.text = "Views: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(500), for: .horizontal)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var exitButton: UIButton = { // КНОПКА ВЫХОДА
        let button = UIButton()
        let image = UIImage(systemName: "clear")
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupView() {
        self.addSubview(self.mainView)
        self.addSubview(self.exitButton)
        self.mainView.addSubview(self.backView)
        self.backView.addSubview(self.authorLabel)
        self.backView.addSubview(self.postImageView)
        self.backView.addSubview(self.descriptionLabel)
        self.backView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.likesLabel)
        self.stackView.addArrangedSubview(self.viewsLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.backView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.backView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.authorLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),

            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            self.postImageView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.backView.widthAnchor, multiplier: 1.0),

            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),

            self.stackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
            self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16),

            self.exitButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.exitButton.heightAnchor.constraint(equalToConstant: 40),
            self.exitButton.widthAnchor.constraint(equalToConstant: 40)
        ])

    }

    @objc private func didTapButton() { //возврат к родительскому вьюконтроллеру
        removeFromSuperview()
    }
}

extension PostView: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }

        self.authorLabel.text = viewModel.author
        self.postImageView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)


    }
}

