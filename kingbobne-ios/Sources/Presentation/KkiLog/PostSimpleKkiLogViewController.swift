//
//  PostKkiLogViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/17.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class PostSimpleKkiLogViewController: UIViewController {
    
    private let viewModel = PostKkiLogViewModelCompanion.newInstance()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "끼록하기"
    }


}
