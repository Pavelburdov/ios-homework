//
//  PostViewController.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    //Заголовок поста

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        //заголовок поста передали из FeedViewProfile()
       // self.navigationItem.title = titlePost
        //настройка бара
        let myBotton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapButton))
        self.navigationItem.rightBarButtonItem = myBotton

    }
    //переход на InfoViewController()
    @objc func didTapButton() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        self.present(infoVC, animated: true)
    }
}
