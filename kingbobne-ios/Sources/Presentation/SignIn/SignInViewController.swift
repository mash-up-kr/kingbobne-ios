//
//  SignInViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/10.
//

import UIKit
import RxCocoa

class SignInViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionButton: ClearButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var completionButton: FullButton!
    @IBOutlet var dividerView: [UIView]!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var emailCheckIcon: UIImageView!
    @IBOutlet weak var passwordCheckIcon: UIImageView!
    
    @IBOutlet weak var completionButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func setUpUI() {
        titleLabel.font = .setFont(style: .Headlineline1Regular)
        titleLabel.textColor = .Custom.brownGray500
        titleLabel.text = "이메일로 로그인"
        emailTextField.placeholder = "이메일 입력"
        emailTextField.textContentType = .emailAddress
        passwordTextField.placeholder = "비밀번호 입력"
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        
        infoLabel.text = "이메일 혹은 비밀번호가 맞지 않습니다."
        infoLabel.font = .setFont(style: .CaptionRegular)
        infoLabel.textColor = .Custom.redError
        
        dividerView.forEach({
            $0.backgroundColor = .Custom.brownGray100
        })
        
        emailCheckIcon.image = .ic_correct_20
        passwordCheckIcon.image = .ic_correct_20
        
        descriptionButton.setButtonStyle(text: "비밀번호를 잊어버렸어요", fontStyle: .Body2Regular, fontColor: .Custom.brownGray300)
        completionButton.setButtonStyle(text: "완료", fontStyle: .Body1Bold, fontColor: .Custom.brownGray300, buttonColor: .Custom.brownGray100)
    }
    
    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        let screenHeight = UIScreen.main.bounds.height
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        var targetHeight = targetFrame!.size.height
        targetHeight -= view.safeAreaInsets.bottom
        var val = targetHeight + 30
        if targetFrame!.origin.y == screenHeight { val = 0 }
        
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curveOpt = UIView.AnimationOptions(rawValue: curve << 16)
            
        UIView.animate(withDuration: duration, delay: 0, options: [curveOpt]) {
            self.completionButtonBottomConstraint.constant = val
        }
        
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curveOpt = UIView.AnimationOptions(rawValue: curve << 16)
            
        UIView.animate(withDuration: duration, delay: 0, options: [curveOpt]) {
            self.completionButtonBottomConstraint.constant = 30
        }
    }

    @IBAction func onFindPassword(_ sender: Any) {
        print("SignInViewController - onFindPassword")
    }
    
    @IBAction func onSignInAction(_ sender: Any) {
        let mainTabBarController = MainTabBarController()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.replaceRootViewController(mainTabBarController, animated: true, completion: nil)
    }
}
