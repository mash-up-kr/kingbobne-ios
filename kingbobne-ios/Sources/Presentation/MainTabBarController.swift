//
//  MainTabBarController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/17.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var homeNavigationController = UINavigationController()
    var postKkiLogNavigationController = UINavigationController()
    var myCookingNavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .Custom.brandOrange
        delegate = self
        
        let homeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let postKkiLogViewController = UIStoryboard(name: "Kkilog", bundle: nil).instantiateViewController(withIdentifier: "PostKkiLogViewController") as! PostKkiLogViewController
        let myCookingViewController = UIStoryboard(name: "MyCooking", bundle: nil).instantiateViewController(withIdentifier: "MyCookingViewController") as! MyCookingViewController
        
        [homeViewController, postKkiLogViewController, myCookingViewController].forEach({
            $0?.navigationItem.largeTitleDisplayMode = .always
        })
        
        homeNavigationController = UINavigationController(rootViewController: homeViewController)
        postKkiLogNavigationController = UINavigationController(rootViewController: postKkiLogViewController)
        myCookingNavigationController = UINavigationController(rootViewController: myCookingViewController)
        
        postKkiLogNavigationController.tabBarItem.image = UIImage.ic_add_44.withRenderingMode(.alwaysOriginal)
        
        selectHomeTab()
        setViewControllers([homeNavigationController, postKkiLogNavigationController, myCookingNavigationController], animated: false)
    }
    
    func selectHomeTab() {
        setHomeTabItem(isSelect: true)
        setMyCookingTabItem(isSelect: false)
    }
    
    func selectPostKkiLogTab() {
        setHomeTabItem(isSelect: false)
        setMyCookingTabItem(isSelect: false)
    }
    
    func selectMyCookingTab() {
        setHomeTabItem(isSelect: false)
        setMyCookingTabItem(isSelect: true)
    }
    
    private func setHomeTabItem(isSelect: Bool) {
        if isSelect {
            homeNavigationController.tabBarItem.image = UIImage.ic_home_active_44.withRenderingMode(.alwaysOriginal)
        } else {
            homeNavigationController.tabBarItem.image = UIImage.ic_home_disable_44.withRenderingMode(.alwaysOriginal)
        }
    }
    
    private func setMyCookingTabItem(isSelect: Bool) {
        if isSelect {
            myCookingNavigationController.tabBarItem.image = UIImage.ic_recipe_active_44.withRenderingMode(.alwaysOriginal)
        } else {
            myCookingNavigationController.tabBarItem.image = UIImage.ic_recipe_disable_44.withRenderingMode(.alwaysOriginal)
        }
    }

}
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case homeNavigationController:
            selectHomeTab()
        case postKkiLogNavigationController:
            selectPostKkiLogTab()
        case myCookingNavigationController:
            selectMyCookingTab()
        default:
            break
        }
    }
}
