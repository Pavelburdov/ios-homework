//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    // создаем tableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self //назначаем делегат
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")// регистрируем ячейку
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")// регистрируем ячейку
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.rowHeight = UITableView.automaticDimension //автоматическое задание высоты ячейки заполняемое контентом
        tableView.estimatedRowHeight = 300
        
        return tableView
    }()

    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private var dataSource: [News.Post] = [] //массив хранящий модели
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPosts { [weak self] posts in
            self?.dataSource = posts // в массив закидываем файлы из json
            self?.tableView.reloadData() //обновление метода dataSourse
        }

        self.setupNavigationBar()
        self.setupView()

    }
    
    private func setupNavigationBar() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }

    private func fetchPosts(completion: @escaping([News.Post]) -> Void) {//получение данных в json формате
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {//подтягиеваем их с моего проекта news.json
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let news = try self.jsonDecoder.decode(News.self, from: data)//декодируем
                print("json data: \(news)")
                completion(news.posts)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    // методы заполнения таблицы
    // Добавляем хедер
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileHeaderView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {

            return 250 // ВЫСОТА HEADER

        } else {

            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {

            return 1

        } else {

            return self.dataSource.count//указываем количество ячеек
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                
                return cell
            }
            
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            
            return cell
        } else {
            // ячейки посты
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            //настраиваем ячейку
            cell.selectionStyle = .none
            cell.delegate = self
            let post = self.dataSource[indexPath.row] //проходим по каждому индексу строки массива
            let viewModel = PostTableViewCell.ViewModel(author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views)//заполняем ячейку
            cell.setup(with: viewModel)
            return cell
        }
    }

    // удаление поста
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let photoVC = PhotosViewController()
            self.navigationController?.pushViewController(photoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if indexPath.row == 0 {
            return .none

        } else {
            
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        tableView.beginUpdates()
        self.dataSource.remove(at: indexPath.row - 1)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
    }
}

extension ProfileViewController: PostTableViewCellProtocol  { // нажатие на лайк или просмотры
    
    func tapPostImageViewGestureRecognizerDelegate(cell: PostTableViewCell) { // УВЕЛИЧЕНИЕ ПРОСМОТРОВ
        let largePostView = PostView()
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        self.dataSource[indexPath.row].views += 1
        let post = self.dataSource[indexPath.row]

        let viewModel = PostView.ViewModel(author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views)
        
        largePostView.setup(with: viewModel)
        self.view.addSubview(largePostView)
        
        largePostView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            largePostView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            largePostView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            largePostView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            largePostView.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    func tapLikeTitleGestureRecognizerDelegate(cell: PostTableViewCell) { // УВЕЛИЧЕНИЕ ЛАЙКОВ
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        self.dataSource[indexPath.row].likes += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
