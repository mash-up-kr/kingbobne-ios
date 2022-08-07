//
//  SignUpViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/07.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

final class SignUpViewController: BaseKeyboardViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: FullButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        infoLabel.font = .setFont(style: .Headlineline1Regular)
        infoLabel.textColor = .Custom.brownGray500
        infoLabel.text = "이메일을 입력해주세요"
        
        dividerView.backgroundColor = .Custom.brownGray100
        
        descriptionLabel.font = .setFont(style: .CaptionRegular)
        descriptionLabel.textColor = .Custom.brownGray400
        descriptionLabel.text = "입력한 이메일로 인증번호가 전송됩니다"
        
        nextButton.setButtonStyle(text: "다음", fontStyle: .Body1Bold, fontColor: .Custom.brownGray300, buttonColor: .Custom.brownGray100)
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        guard let targetHeight = getKeyboardHeight(notification: notification) else { return }
        
        let keyboardAnim = getKeyboardAnimationValue(notification: notification)
        if let duration = keyboardAnim.duration, let curveOpt = keyboardAnim.curveOption {
            UIView.animate(withDuration: duration, delay: 0, options: curveOpt, animations: {
                self.nextButtonBottomConstraint.constant = targetHeight + 30
            })
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        let keyboardAnim = getKeyboardAnimationValue(notification: notification)
        if let duration = keyboardAnim.duration, let curveOpt = keyboardAnim.curveOption {
            UIView.animate(withDuration: duration, delay: 0, options: curveOpt, animations: {
                self.nextButtonBottomConstraint.constant = 30
            })
        }
    }
    
    

}
