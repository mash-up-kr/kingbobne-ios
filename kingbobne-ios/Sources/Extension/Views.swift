//
//  Views.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/31.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

extension UIView {
    func loadXib() {
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self)
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        self.addSubview(customView)
    }
}
