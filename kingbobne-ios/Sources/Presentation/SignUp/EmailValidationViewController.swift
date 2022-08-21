//
//  SignUpViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/07.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class EmailValidationViewController: BaseKeyboardViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: FullButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    private let viewModel: EmailValidationViewModel = EmailValidationViewModelCompanion.newInstance()
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        observeEmailTextFieldChanged()
        observeNextButtonClicked()
        observeAuthCodeRequested()
        
        observeEmailState()
    }
    
    private func observeEmailTextFieldChanged() {
        emailTextField.rx.text
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { email in
                    self.viewModel.validateEmail(email: email ?? "")
                    if email == "" {
                        self.dividerView.backgroundColor = .Custom.brownGray100
                    } else {
                        self.dividerView.backgroundColor = .Custom.brandOrange
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeEmailState() {
        observeEmailValidatedState()
        observeEmaiilErrorState()
        
        viewModel.observeViewState()
            .map { viewState in
                viewState.btnReuqestAuthEnabled
            }
            .subscribe(
                onNext: { btnEnabled in
                    self.nextButton.isEnabled = btnEnabled
                    if btnEnabled {
                        self.nextButton.setButtonStyle(text: "다음", fontStyle: .Body1Bold, fontColor: .white, buttonColor: .Custom.brandOrange)
                    } else {
                        self.nextButton.setButtonStyle(text: "다음", fontStyle: .Body1Bold, fontColor: .Custom.brownGray300, buttonColor: .Custom.brownGray100)
                    }
                    
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeEmaiilErrorState() {
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
                    self.descriptionLabel.text = "올바른 이메일 형식을 입력해주세요.\n예시) KKILOG@Gmail.com"
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
                    // TODO set email validate
                    self.descriptionLabel.text = ""
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func observeNextButtonClicked() {
        nextButton.rx.tap
            .bind {
                self.viewModel.requestAuthCodeBy(email: self.emailTextField.text ?? "")
                self.descriptionLabel.text = "입력한 이메일로 인증번호가 전송됩니다"
            }
            .disposed(by: disposeBag)
    }
    
    private func observeAuthCodeRequested() {
        viewModel.observeViewState()
            .filter { viewState in
                viewState.authCodeLoadingState == .success(data: ())
            }
            .subscribe(
                onNext: { _ in
                    let authCodeViewController = AuthCodeViewController()
                    self.navigationController?.pushViewController(authCodeViewController, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setUpUI() {
        infoLabel.font = .setFont(style: .Headline1Regular)
        infoLabel.textColor = .Custom.brownGray500
        infoLabel.text = "이메일을 입력해주세요"
        
        emailTextField.placeholder = "KKILOG@Gmail.com"
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
