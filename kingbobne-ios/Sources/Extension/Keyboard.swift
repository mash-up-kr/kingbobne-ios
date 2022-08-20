//
//  Keyboard.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/07.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class keyboardAnim: NSObject {
    var curve: UInt? = nil
    var duration: Double? = nil
    var curveOption: UIView.AnimationOptions? = nil
    
    init(curve: UInt, duration: Double, curveOption: UIView.AnimationOptions) {
        self.curve = curve
        self.duration = duration
        self.curveOption = curveOption
    }
}

extension UIViewController {
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        let screenHeight = UIScreen.main.bounds.height
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        var targetHeight = targetFrame!.size.height
        targetHeight -= view.safeAreaInsets.bottom
        
        if targetFrame!.origin.y == screenHeight {
            return nil
        }
        return targetHeight
    }
    
    @objc func getKeyboardAnimationValue(notification: NSNotification) -> keyboardAnim {
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curveOpt = UIView.AnimationOptions(rawValue: curve << 16)
        return keyboardAnim(curve: curve, duration: duration, curveOption: curveOpt)
    }
}
