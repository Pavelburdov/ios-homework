//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Pavel on 22.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }


        self.window = UIWindow(windowScene: windowScene)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UITabBarController()
        //создадим два навигационных контроллера
//        let feedViewController = UINavigationController(rootViewController: FeedViewController())
//        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [feedViewController, profileViewController]
        self.window?.rootViewController = createTabBarController()
//        tabBarController = UINavigationController(rootViewController: FeedViewController(), rootViewController: ProfileViewController())

    }
    //Настройка TabBar
    //Создаем функцию контроллера поисковой навигации, который возвращает контроллер пользовательского интерфейса
    func createFeedViewController() -> UINavigationController {
        //Инициализируем поисковый контроллер
        let feedViewController = FeedViewController()
        // Добавляем заголовок который отобразиться вверху экрана
        feedViewController.title = "Лента"
        //настроим и саму кнопку, добавив на нее иконку и название. Создаем элемент панели вкладок пользовательского интерфейса UITabBarIt, где title: это заголовок, а image: в нашем случае системная иконка, tag:это индекс положения, где 0 - положение слева, а 1 справа
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext.fill"), tag: 0)
        //Возвращаем навигатор пользовательского интерфейса
        return UINavigationController(rootViewController: feedViewController)
    }

    //Настройка TabBar
    //Создаем функцию контроллера поисковой навигации, который возвращает контроллер пользовательского интерфейса
    func createProfileViewController() -> UINavigationController {
        //Инициализируем поисковый контроллер
        let profileViewController = ProfileViewController()
        // Добавляем заголовок который отобразиться вверху экрана
        profileViewController.title = "Профиль"
        //настроим и саму кнопку, добавив на нее иконку и название. Создаем элемент панели вкладок пользовательского интерфейса UITabBarIt, где title: это заголовок, а image: в нашем случае системная иконка, tag:это индекс положения, где 0 - положение слева, а 1 справа
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle.fill"), tag: 1)
        //Возвращаем навигатор пользовательского интерфейса
        return UINavigationController(rootViewController: profileViewController)
    }

    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .systemGray6
        tabBarController.viewControllers = [createFeedViewController(), createProfileViewController()]
        return tabBarController
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

