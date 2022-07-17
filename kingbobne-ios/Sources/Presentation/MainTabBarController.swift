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
        
        let homeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let postKkiLogViewController = UIStoryboard(name: "Kkilog", bundle: nil).instantiateViewController(withIdentifier: "PostKkiLogViewController") as! PostKkiLogViewController
        let myCookingViewController = UIStoryboard(name: "MyCooking", bundle: nil).instantiateViewController(withIdentifier: "MyCookingViewController") as! MyCookingViewController
        
        homeViewController.title = "홈"
        postKkiLogViewController.title = "끼록하기"
        myCookingViewController.title = "내 요리"
        
        [homeViewController, postKkiLogViewController, myCookingViewController].forEach({
            $0?.navigationItem.largeTitleDisplayMode = .always
        })
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let postKkiLogNavigationController = UINavigationController(rootViewController: postKkiLogViewController)
        let myCookingNavigationController = UINavigationController(rootViewController: myCookingViewController)
        
        setViewControllers([homeNavigationController, postKkiLogNavigationController, myCookingNavigationController], animated: false)
        
        
    }

}
