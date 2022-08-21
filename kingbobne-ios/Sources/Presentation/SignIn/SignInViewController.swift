//
//  SignInViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/10.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftUI

final class SignInViewController: BaseKeyboardViewController {

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
        
        viewModel.observeViewState()
            .map { viewState in
                viewState.emailState
            }
            .filter { emailState in
                emailState.message == ValidationState.VALIDATION_FORMAT_ERROR_MESSAGE
            }
            .subscribe(
                onNext: { emailState in
                    self.setUIEmailInitialized()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeEmailErrorState() {
        viewModel.observeViewState()
            .map { viewState in
                viewState.emailState
            }
            .filter { emailState in
                !emailState.validated && emailState.message != nil
            }
            .filter { emailState in
                emailState.message != ValidationState.VALIDATION_FORMAT_ERROR_MESSAGE
            }
            .map { emailState in
                emailState.message!
            }
            .subscribe(
                onNext: { message in
                    self.setUIEmailError(errorMessage: message)
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
                    self.setUIEmailValidated()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observePasswordState() {
        observePasswordValidatedState()
        observePasswordErrorState()
        
        viewModel.observeViewState()
            .map { viewState in
                viewState.passwordState
            }
            .filter { passwordState in
                passwordState.message == ValidationState.VALIDATION_FORMAT_ERROR_MESSAGE
            }
            .subscribe(
                onNext: { emailState in
                    self.setUIPasswordInitialized()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observePasswordErrorState() {
        viewModel.observeViewState()
            .map { viewState in
                viewState.passwordState
            }
            .filter { passwordState in
                !passwordState.validated && passwordState.message != nil
            }
            .filter { passwordState in
                passwordState.message != ValidationState.VALIDATION_FORMAT_ERROR_MESSAGE
            }
            .map { passwordState in
                passwordState.message!
            }
            .subscribe(
                onNext: { message in
                    self.setUIPasswordError(errorMessage: message)
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
                    self.setUIPasswordValidated()
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
    
    func setUpUI() {
        titleLabel.font = .setFont(style: .Headline1Regular)
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
        infoLabel.isHidden = true
        
        dividerView.forEach({
            $0.backgroundColor = .Custom.brownGray100
        })
        
        emailCheckIcon.isHidden = true
        passwordCheckIcon.isHidden = true
        
        descriptionButton.setButtonStyle(text: "비밀번호를 잊어버렸어요", fontStyle: .Body2Regular, fontColor: .Custom.brownGray300)
        completionButton.setButtonStyle(text: "완료", fontStyle: .Body1Bold, fontColor: .Custom.brownGray300, buttonColor: .Custom.brownGray100)
    }
    

    private func setUIEmailInitialized() {
        emailCheckIcon.isHidden = true
        
        // TODO divider color init
    }
    
    private func setUIEmailValidated() {
        emailCheckIcon.image = .ic_correct_20
        emailCheckIcon.isHidden = false
        
        emailTextField.layer.borderColor = UIColor.Custom.brownGray100.cgColor
    }
    
    private func setUIEmailError(errorMessage: String) {
        if errorMessage.isEmpty {
            emailCheckIcon.isHidden = true
            emailTextField.layer.borderColor = UIColor.Custom.brownGray100.cgColor
            // TODO textfield underline setting
        } else {
            emailCheckIcon.image = .ic_error_20
            emailCheckIcon.isHidden = false
            emailTextField.layer.borderColor = UIColor.Custom.redError.cgColor
            // TODO textfield underline setting
        }
    }
    
    private func setUIPasswordInitialized() {
        passwordCheckIcon.isHidden = true
        
        // TODO divider color init
    }
    
    private func setUIPasswordValidated() {
        passwordCheckIcon.image = .ic_correct_20
        passwordCheckIcon.isHidden = false
        
        passwordTextField.layer.borderColor = UIColor.Custom.brownGray100.cgColor
    }
    
    private func setUIPasswordError(errorMessage: String) {
        if errorMessage.isEmpty {
            passwordCheckIcon.isHidden = true
            // TODO textfield underline setting
            passwordTextField.layer.borderColor = UIColor.Custom.brownGray100.cgColor
        } else {
            passwordCheckIcon.image = .ic_error_20
            passwordCheckIcon.isHidden = false
            // TODO textfield underline setting
            passwordTextField.layer.borderColor = UIColor.Custom.redError.cgColor
        }
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        guard let targetHeight = getKeyboardHeight(notification: notification) else { return }
        
        let keyboardAnim = getKeyboardAnimationValue(notification: notification)
        if let duration = keyboardAnim.duration, let curveOpt = keyboardAnim.curveOption {
            UIView.animate(withDuration: duration, delay: 0, options: curveOpt, animations: {
                self.completionButtonBottomConstraint.constant = targetHeight + 30
            })
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        let keyboardAnim = getKeyboardAnimationValue(notification: notification)
        if let duration = keyboardAnim.duration, let curveOpt = keyboardAnim.curveOption {
            UIView.animate(withDuration: duration, delay: 0, options: curveOpt, animations: {
                self.completionButtonBottomConstraint.constant = 30
            })
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
