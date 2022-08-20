//
//  SelectKkiLogViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import UIKit
import PanModal

class SelectKkiLogViewController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
            return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        panModalSetNeedsLayoutUpdate()
    }
}
