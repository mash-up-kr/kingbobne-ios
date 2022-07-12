//
//  SplashViewController.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation
import UIKit
import RxSwift

class SplashViewController: UIViewController {
    private let STORYBOARD_SIGN_NAME = "Sign"
    private let STORYBOARD_SIGN_NAVIGATION_IDENTIFIER = "SignNavigationViewController"
    
    
    private let viewModel = SplashViewModelCompanion.newInstance()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView = UIView()
        backgroundView.backgroundColor = .Custom.loginBackground
        
        self.view.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        viewModel.observeState()
            .subscribe(
                onSuccess: { state in
                    switch(state) {
                    case .NAVIGATE_TO_SIGN:
                        self.navigateToSign()
                    case .NAVIGATE_TO_HOME:
                        self.navigateToHome()
                    }
                },
                onFailure: { _ in }
            )
            .disposed(by: disposeBag)
        
        viewModel.refresh()
    }
    
    private func navigateToSign() {
        let storyboard = UIStoryboard.init(name: STORYBOARD_SIGN_NAME, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: STORYBOARD_SIGN_NAVIGATION_IDENTIFIER)
        
        UIApplication.shared.windows.first?.replaceRootViewController(viewController)
    }
    
    private func navigateToHome() {
        // TODO 
    }
    
}
