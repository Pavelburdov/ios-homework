//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cat")
        imageView.frame = CGRect(x: 16, y: 16, width: 150, height: 150)
        imageView.layer.borderWidth = 3.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 75
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cat"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Hunting"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton()
       // button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(didTapMyButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf(){
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusButton)
        self.addSubview(imageView)

        let topAnchorNameLabel =  nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leadingAnchorNameLabel = nameLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 160)
        let trailingAnchorNameLabel = nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightAnchorNameLabel = nameLabel.heightAnchor.constraint(equalToConstant: 30)

        let leadingAnchorStatusLabel = statusLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 160)
        let trailingStatusLabel = statusLabel.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor, constant: -16)
        let heightAnchorStatusLabel = statusLabel.heightAnchor.constraint(equalToConstant: 30)
        let bottomAnchorStatusLabel = statusLabel.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -34)

        let leadingAnchorButton = statusButton.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor)
        let trailingAnchorStatusButton = statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let topAnchorStatusButton = statusButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 16)
        let heightAnchorStatusButton = statusButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([topAnchorNameLabel, leadingAnchorNameLabel, trailingAnchorNameLabel, heightAnchorNameLabel, leadingAnchorStatusLabel, trailingStatusLabel, heightAnchorStatusLabel, bottomAnchorStatusLabel, leadingAnchorButton, trailingAnchorStatusButton, topAnchorStatusButton, heightAnchorStatusButton])
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {



    }
    

    @objc func didTapMyButton(){
        let status = self.statusLabel.text
        if status != nil {
            print(status!)
    }
}
}
