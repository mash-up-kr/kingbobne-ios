//
//  SignInViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/10.
//

import UIKit
import RxCocoa
import RxSwift

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
    
    private let viewModel: SignInViewModel = SignInViewModelCompanion.newInstance()
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
        
        observeEmailTextFieldChanged()
        observePasswordTextFieldChanged()
        observeCompletionButtonClicked()
        
        observeEmailState()
        observePasswordState()
        observeSignInButtonActivated()
        observeSignInState()
    }
    
    private func observeEmailTextFieldChanged() {
        emailTextField.rx.text
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { email in
                    self.viewModel.validateEmail(email: email ?? "")
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observePasswordTextFieldChanged() {
        passwordTextField.rx.text
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { password in
                    self.viewModel.validatePassword(password: password ?? "")
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeCompletionButtonClicked() {
        completionButton.rx.tap
            .bind {
                self.viewModel.signIn(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")
            }
            .disposed(by: disposeBag)
    }
    
    private func observeEmailState() {
        observeEmailValidatedState()
        observeEmailErrorState()
    }
    
    private func observeEmailErrorState() {
        viewModel.observeViewState()
            .map { viewState in
                viewState.emailState
            }
            .filter { emailState in
                !emailState.validated && emailState.message != nil
            }
            .map { emailState in
                emailState.message!
            }
            .subscribe(
                onNext: { message in
                    // TODO show email error message
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeEmailValidatedState() {
        viewModel.observeViewState()
            .filter { viewState in
                viewState.emailState.validated
            }
            .subscribe(
                onNext: { _ in
                    // TODO resolve error messages and state
                    print("email validated")
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observePasswordState() {
        observePasswordValidatedState()
        observePasswordErrorState()
    }
    
    private func observePasswordErrorState() {
        viewModel.observeViewState()
            .map { viewState in
                viewState.passwordState
            }
            .filter { passwordState in
                !passwordState.validated && passwordState.message != nil
            }
            .map { passwordState in
                passwordState.message!
            }
            .subscribe(
                onNext: { message in
                    // TODO show password error message
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observePasswordValidatedState() {
        viewModel.observeViewState()
            .filter { viewState in
                viewState.passwordState.validated
            }
            .subscribe(
                onNext: { _ in
                    // TODO resolve error messages and state
                    print("password validated")
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeSignInButtonActivated() {
        viewModel.observeViewState()
            .map { viewState in
                viewState.emailPasswordValidated
            }
            .subscribe(
                onNext: { btnActivated in
                    self.completionButton.isEnabled = btnActivated
                }
            )
            .disposed(by: disposeBag)
    }
    
    
    private func observeSignInState() {
        viewModel.observeViewState()
            .filter { viewState in
                viewState.signInLoadingState == .loading
            }
            .subscribe(
                onNext: { _ in
                    self.showLoadingDialog()
                }
            )
            .disposed(by: disposeBag)
        
        viewModel.observeViewState()
            .filter { viewState in
                viewState.signInLoadingState == .success(data: ())
            }
            .subscribe(
                onNext: { _ in
                    self.navigateToHome()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func showLoadingDialog() {
        // TODO
    }
    
    private func navigateToHome() {
        // TODO
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func setUpUI() {
        titleLabel.font = .setFont(style: .Headlineline1Regular)
        titleLabel.textColor = .Custom.brownGray500
        titleLabel.text = "???????????? ?????????"
        emailTextField.placeholder = "????????? ??????"
        emailTextField.textContentType = .emailAddress
        
        passwordTextField.placeholder = "???????????? ??????"
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        
        infoLabel.text = "????????? ?????? ??????????????? ?????? ????????????."
        infoLabel.font = .setFont(style: .CaptionRegular)
        infoLabel.textColor = .Custom.redError
        
        dividerView.forEach({
            $0.backgroundColor = .Custom.brownGray100
        })
        
        emailCheckIcon.image = .ic_correct_20
        passwordCheckIcon.image = .ic_correct_20
        
        descriptionButton.setButtonStyle(text: "??????????????? ??????????????????", fontStyle: .Body2Regular, fontColor: .Custom.brownGray300)
        completionButton.setButtonStyle(text: "??????", fontStyle: .Body1Bold, fontColor: .Custom.brownGray300, buttonColor: .Custom.brownGray100)
        
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
