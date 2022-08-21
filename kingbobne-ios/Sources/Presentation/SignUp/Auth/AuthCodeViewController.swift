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

class AuthCodeViewController: BaseKeyboardViewController {
    private let viewModel = AuthCodeViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        let contentView = UIHostingController(rootView: AuthCodeView(viewModel: self.viewModel))
        contentView.loadView()
        addChild(contentView)
        view.addSubview(contentView.view)
        setupContsraints(contentView: contentView)
        
        viewModel.observeViewState()
            .filter { viewState in
                viewState.authCodeLoadingState == .success(data: ())
            }
            .subscribe(
                onNext: { viewState in
                    let passwordViewController = PasswordViewController()
                    self.navigationController?.pushViewController(passwordViewController, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupContsraints(contentView: UIHostingController<AuthCodeView>) {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
