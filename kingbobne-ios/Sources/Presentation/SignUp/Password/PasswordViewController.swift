//
//  AuthCodeViewController.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift

class PasswordViewController: BaseKeyboardViewController {
    private let viewModel = PasswordViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        let contentView = UIHostingController(rootView: PasswordView(viewModel: self.viewModel))
        contentView.loadView()
        addChild(contentView)
        view.addSubview(contentView.view)
        setupContsraints(contentView: contentView)
        
        guard let navigationController = self.navigationController else {
            return
        }
        navigationController.viewControllers.remove(at: navigationController.viewControllers.count - 2)
        
        viewModel.observePasswordSaved()
            .filter { passwordSaved in
                passwordSaved
            }
            .subscribe(
                onNext: { _ in
                    let nicknameViewController = NicknameViewController()
                    self.navigationController?.pushViewController(nicknameViewController, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupContsraints(contentView: UIHostingController<PasswordView>) {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

