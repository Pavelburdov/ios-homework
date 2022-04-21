//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Pavel on 06.04.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    private enum TabBarItem {

        case feed
        case profile

        var title: String {
            switch self {
                case .feed:
                    return "Лента"
                case .profile:
                    return "Профиль"
            }
        }
        var iconName: UIImage? {
            switch self {
                case .feed:
                    return UIImage(systemName: "house.circle")
                case .profile:
                    return UIImage(systemName: "person.circle")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }

    func setupTabBar() {
        let itemBar: [TabBarItem] = [.feed, .profile]
        self.viewControllers = itemBar.map ( { tabBarItem in
            switch tabBarItem {
                case .feed:
                    return UINavigationController(rootViewController: FeedViewController())
                case .profile:
                    return UINavigationController(rootViewController: ProfileViewController())
            }
        })
        
        self.viewControllers?.enumerated().forEach ({ (index, vc) in
            vc.tabBarItem.title = itemBar[index].title
            vc.tabBarItem.image = itemBar[index].iconName
        })
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

