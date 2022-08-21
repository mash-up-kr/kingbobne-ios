//
//  NicknameViewController.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/21.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift

class NicknameViewController: BaseKeyboardViewController {
    private let viewModel = NicknameViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        let contentView = UIHostingController(rootView: NicknameView(viewModel: self.viewModel))
        contentView.loadView()
        addChild(contentView)
        view.addSubview(contentView.view)
        setupContsraints(contentView: contentView)
        
        viewModel.observeSignUpLoadingState()
            .subscribe(
                onNext: { loadingState in
                    if (loadingState == .success(data: ())) {
                        let characterViewController = CharacterViewController()
                        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.replaceRootViewController(characterViewController, animated: true, completion: nil)
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupContsraints(contentView: UIHostingController<NicknameView>) {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

