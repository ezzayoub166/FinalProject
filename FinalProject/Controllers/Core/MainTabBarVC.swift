//
//  MainTabBarVC.swift
//  FinalProject
//
//  Created by ezz on 01/12/2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MAIN")
        let vc1 = UINavigationController(rootViewController: oredersVC())
        let vc2 = UINavigationController(rootViewController: compainesVC())
        let vc3 = UINavigationController(rootViewController: settingsVC())
        
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        vc2.tabBarItem.image = UIImage(systemName: "building.2")
        vc3.tabBarItem.image = UIImage(systemName: "gear.circle")
        
        vc1.title = "الطلبات"
        vc2.title = "الشركات"
        vc3.title = "الإعدادات"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .white
        setViewControllers([vc3,vc2,vc1], animated: true)

    }
    


}
