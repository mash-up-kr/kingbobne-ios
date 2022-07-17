//
//  MainTabBarController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/17.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .Custom.brandOrange
        
        let homeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let postKkiLogViewController = UIStoryboard(name: "Kkilog", bundle: nil).instantiateViewController(withIdentifier: "PostKkiLogViewController") as! PostKkiLogViewController
        let myCookingViewController = UIStoryboard(name: "MyCooking", bundle: nil).instantiateViewController(withIdentifier: "MyCookingViewController") as! MyCookingViewController
        
        [homeViewController, postKkiLogViewController, myCookingViewController].forEach({
            $0?.navigationItem.largeTitleDisplayMode = .always
        })
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let postKkiLogNavigationController = UINavigationController(rootViewController: postKkiLogViewController)
        let myCookingNavigationController = UINavigationController(rootViewController: myCookingViewController)
        
        homeNavigationController.tabBarItem.image = UIImage.ic_home_disable_44.withRenderingMode(.alwaysOriginal)
        postKkiLogNavigationController.tabBarItem.image = UIImage.ic_add_44.withRenderingMode(.alwaysOriginal)
        myCookingNavigationController.tabBarItem.image = UIImage.ic_recipe_disable_44.withRenderingMode(.alwaysOriginal)
        
        setViewControllers([homeNavigationController, postKkiLogNavigationController, myCookingNavigationController], animated: false)
        
        
    }

}
