//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Pavel on 08.04.2022.
//

import UIKit

protocol PostTableViewCellProtocol: AnyObject {
    func tapPostImageViewGestureRecognizerDelegate(cell: PostTableViewCell)
    func tapLikeTitleGestureRecognizerDelegate(cell: PostTableViewCell)
}

final class PostTableViewCell: UITableViewCell {

    weak var delegate: PostTableViewCellProtocol?

    private var tapPostImageViewGestureRecognizerDelegate = UITapGestureRecognizer()
    private var tapLikeTitleGestureRecognizerDelegate = UITapGestureRecognizer()
    
    struct ViewModel: ViewModelProtocol {
        let author, description, image: String
        var likes: Int
        var views: Int
    }

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
        label.numberOfLines = 2
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
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy  var descriptionLabel: UILabel = { //статья
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "Likes: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.text = "Views: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() { //обнуление информации в ячейках
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.postImageView.image = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }

    private func setupView() {

        self.contentView.addSubview(self.stackView)
        self.contentView.addSubview(self.authorLabel)
        self.contentView.addSubview(self.postImageView)
        self.contentView.addSubview(self.descriptionLabel)
        self.stackView.addArrangedSubview(self.likesLabel)
        self.stackView.addArrangedSubview(self.viewsLabel)
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            self.postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1.0),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.stackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}


extension PostTableViewCell: Setupable {
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.authorLabel.text = viewModel.author
        self.postImageView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " +  String(viewModel.views)
    }
}

extension PostTableViewCell {

    private func setupGesture() {
        self.tapLikeTitleGestureRecognizerDelegate.addTarget(self, action: #selector(self.likesHandleTapGesture(_:)))
        self.likesLabel.addGestureRecognizer(self.tapLikeTitleGestureRecognizerDelegate)
        self.likesLabel.isUserInteractionEnabled = true

        self.tapPostImageViewGestureRecognizerDelegate.addTarget(self, action: #selector(self.postsHandleTapGesture(_:)))
        self.postImageView.addGestureRecognizer(self.tapPostImageViewGestureRecognizerDelegate)
        self.postImageView.isUserInteractionEnabled = true
    }


    @objc func likesHandleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapLikeTitleGestureRecognizerDelegate === gestureRecognizer else { return }
        delegate?.tapLikeTitleGestureRecognizerDelegate(cell: self)
    }

    @objc func postsHandleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapPostImageViewGestureRecognizerDelegate === gestureRecognizer else { return }
        delegate?.tapPostImageViewGestureRecognizerDelegate(cell: self)
    }
}
