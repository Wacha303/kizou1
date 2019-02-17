//
//  ViewController.swift
//  kizou
//
//  Created by 中原雄太 on 2019/01/17.
//  Copyright © 2019年 中原雄太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI


class MainTabBarController: UITabBarController {
   
    var navBar: UINavigationBar!
    var vc2: UIViewController!
    var navItem: UINavigationItem!
    var navBarButton: UIBarButtonItem!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2つViewControllerを用意
        let homeViewController = HomeViewController()
        let searchViewController = SearchViewController()
        
        homeViewController.title = "ホーム"
        searchViewController.title = "検索"
        
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.history, tag: 1)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 2)
        
        let navigationController1 = UINavigationController(rootViewController: homeViewController)
        let navigationController2 = UINavigationController(rootViewController: searchViewController)
        
        //2つのViewControllerをArrayでまとめます
        let tabs = [navigationController1, navigationController2]
        self.viewControllers = tabs

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
