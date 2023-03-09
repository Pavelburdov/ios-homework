//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Pavel on 12.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private enum Constant {
        static let itemCount: CGFloat = 4
    }

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)

        return stackView
    }()

    private lazy var titleLabel: UILabel = {  // ЗАГОЛОВОК
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)

        return label
    }()

    private lazy var arrowImage: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true

        return imageView

    }()


    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8

        return layout
    }()
    // метод для скролвью
    private lazy var photoCollectionView: UICollectionView = {  // PHOTO
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollection")
        stackView.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .systemGray6
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.arrowImage)
        self.backView.addSubview(photoCollectionView)
        activateConstraints()
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12),
            self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12),
            self.arrowImage.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.photoCollectionView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            self.photoCollectionView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            self.photoCollectionView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12),
            self.photoCollectionView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor),
            self.photoCollectionView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25)
        ])
    }

    // метод для размещения отображаемого контента, где задаем размеры для фоток
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let needWidth = width - 4 * spacing
        let itemWidth = floor(needWidth / Constant.itemCount)

        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return carImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollection", for: indexPath) as! PhotosCollectionViewCell //у ячеке есть свойство dequeueReusableCell для переиспользования ячеек

        let car = carImage[indexPath.row]
        let viewModel = PhotosCollectionViewCell.ViewModel(image: car.image)
        cell.setup(with: viewModel)

        return cell
    }
}

extension PhotosTableViewCell : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing

        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}
