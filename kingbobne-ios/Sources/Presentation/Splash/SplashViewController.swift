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
    
    private let viewModel = SplashViewModelCompanion.newInstance()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.observeState()
            .subscribe(
                onSuccess: { state in
                    switch(state) {
                    case .NAVIGATE_TO_LOGIN:
                        self.navigateToLogin()
                    case .NAVIGATE_TO_HOME:
                        self.navigateToHome()
                    }
                },
                onFailure: { _ in }
            )
            .disposed(by: disposeBag)
    }
    
    private func navigateToLogin() {
        
    }
    
    private func navigateToHome() {
        
    }
    
}
