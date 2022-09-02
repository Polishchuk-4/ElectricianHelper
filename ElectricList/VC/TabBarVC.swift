//
//  TabBarVC.swift
//  CoreData
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addControllers()
        self.tabBar.tintColor = .text
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.barTintColor = UIColor.background
    }
    
    
    
    private func addControllers() {
        let roomList = RoomListVC()
        let roomListNavVC = UINavigationController(rootViewController: roomList)
        let roomListImage = UIImage(systemName: "list.bullet.below.rectangle")
        roomListNavVC.tabBarItem = UITabBarItem(title: "Rooms", image: roomListImage, tag: 0)
        roomListNavVC.navigationBar.barTintColor = UIColor.background
        
        let switchList = SwitchesListVC()
        let switchListNavVC = UINavigationController(rootViewController: switchList)
        let switchListImage = UIImage(systemName: "list.bullet.rectangle.portrait")
        switchListNavVC.tabBarItem = UITabBarItem(title: "Switches", image: switchListImage, tag: 1)
        switchListNavVC.navigationBar.barTintColor = UIColor.background
        
        self.viewControllers = [roomListNavVC, switchListNavVC]
    }
}
