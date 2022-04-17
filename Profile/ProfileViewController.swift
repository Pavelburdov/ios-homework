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
        let tableView = UITableView()
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

    private lazy var tableHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private var heightConstraint: NSLayoutConstraint?

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
        self.tableView.tableHeaderView = tableHeaderView
        self.setupNavigationBar()
        self.setupView()
        //tapGesture()
        setupProfileHeaderView()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }

    private func setupView() {
        self.view.addSubview(self.tableView)

        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }

    private func setupProfileHeaderView() {
        self.view.backgroundColor = .lightGray

        let topConstraint = self.tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor)
        let leadingConstraint = self.tableHeaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        let trailingConstraint = self.tableHeaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        let widthConstraint = self.tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor)
        self.heightConstraint = self.tableHeaderView.heightAnchor.constraint(equalToConstant: 220)
        let bottomConstraint = self.tableHeaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)

        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, widthConstraint, heightConstraint, bottomConstraint].compactMap({ $0 }))
    }


    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: CGFloat(heightConstraint!.constant))).height
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1 //указываем количество ячеек
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
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
            let post = self.dataSource[indexPath.row - 1] //проходим по каждому индексу строки массива
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

extension ProfileViewController: ProfileHeaderViewProtocol {
    func didTapMyButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 250:220
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(0..<1), with: .automatic)
        tableView.endUpdates()

        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: PostTableViewCellProtocol  { // нажатие на лайк или просмотры

    func tapPostImageViewGestureRecognizerDelegate(cell: PostTableViewCell) { // УВЕЛИЧЕНИЕ ПРОСМОТРОВ {
        let largePostView = PostView()
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 0)
        let post = self.dataSource[indexPath.row - 1]


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

        self.dataSource[indexPath.row - 1].views += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)

    }

    func tapLikeTitleGestureRecognizerDelegate(cell: PostTableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 0)
        self.dataSource[indexPath.row - 1].likes += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
