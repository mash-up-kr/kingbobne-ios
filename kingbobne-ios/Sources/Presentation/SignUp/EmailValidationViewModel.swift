//
//  SignUpViewModel.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/14.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

protocol EmailValidationViewModel {
    func validateEmail(email: String)
    func requestAuthCodeBy(email: String)
    func observeViewState() -> Observable<EmailValidationViewState>
}

class EmailValidationViewModelCompanion {
    static func newInstance() -> EmailValidationViewModel {
        let signUpRepository = SignUpResitoryCompanion.getInstance()
        return EmailValidationViewModelImpl(signUpRepository: signUpRepository)
    }
}

fileprivate class EmailValidationViewModelImpl: EmailValidationViewModel {
    
    private static let REGEX_EMAIL = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let signUpRepository: SignUpRepository
    private let emailValidationViewStateSubject = BehaviorSubject<EmailValidationViewState>(value: EmailValidationViewState())
    
    init(signUpRepository: SignUpRepository) {
        self.signUpRepository = signUpRepository
    }
    
    func observeViewState() -> Observable<EmailValidationViewState> {
        return emailValidationViewStateSubject.distinctUntilChanged()
            .observe(on: MainScheduler.instance)
    }
    
    func validateEmail(email: String) {
        do {
            let regex = try NSRegularExpression(pattern: EmailValidationViewModelImpl.REGEX_EMAIL)
            let results = regex.matches(in: email, range: NSRange(location: 0, length: email.count))
            var viewState = try self.emailValidationViewStateSubject.value()
            if results.isEmpty {
                viewState.emailState.validated = false
                viewState.emailState.message = ValidationState.VALIDATION_FORMAT_ERROR_MESSAGE
                emailValidationViewStateSubject.onNext(viewState)
            } else {
                viewState.emailState.validated = true
                viewState.emailState.message = nil
                emailValidationViewStateSubject.onNext(viewState)
            }
        } catch {
            
        }
    }
    
    func requestAuthCodeBy(email: String) {
        signUpRepository.validateEmail(email: email)
            .andThen(signUpRepository.requestAuthCode(email: email))
            .do(
                onError: { error in
                    
                    print("requestAuthCode error" + error.localizedDescription)
                    
                },
                onCompleted: {
                    print("requestAuthCode success")
                },
                onSubscribe: {
                    do {
                        var viewState = try self.emailValidationViewStateSubject.value()
                        viewState.authCodeLoadingState = LoadingState.loading
                        self.emailValidationViewStateSubject.onNext(viewState)
                    } catch {}
                }
            )
            .subscribe(
                onCompleted: {
                    do {
                        var viewState = try self.emailValidationViewStateSubject.value()
                        viewState.authCodeLoadingState = LoadingState.success(data: ())
                        self.emailValidationViewStateSubject.onNext(viewState)
                    } catch {}
                }, onError: { error in
                    do {
                        var viewState = try self.emailValidationViewStateSubject.value()
                        viewState.authCodeLoadingState = LoadingState.error(error: error)
                        self.emailValidationViewStateSubject.onNext(viewState)
                    } catch {}
                }
            ).disposed(by: disposeBag)
    }
    
}

