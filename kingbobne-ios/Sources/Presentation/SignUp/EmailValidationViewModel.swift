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
        let signRepository = SignRepositoryCompanion.getInstance()
        return EmailValidationViewModelImpl(signRepository: signRepository)
    }
}

fileprivate class EmailValidationViewModelImpl: EmailValidationViewModel {
    
    private static let REGEX_EMAIL = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let signRepository: SignRepository
    private let signUpViewStateSubject = BehaviorSubject<EmailValidationViewState>(value: EmailValidationViewState())
    
    init(signRepository: SignRepository) {
        self.signRepository = signRepository
    }
    
    func observeViewState() -> Observable<EmailValidationViewState> {
        return signUpViewStateSubject.distinctUntilChanged()
            .observe(on: MainScheduler.instance)
    }
    
    func validateEmail(email: String) {
        do {
            let regex = try NSRegularExpression(pattern: EmailValidationViewModelImpl.REGEX_EMAIL)
            let results = regex.matches(in: email, range: NSRange(location: 0, length: email.count))
            var viewState = try self.signUpViewStateSubject.value()
            if results.isEmpty {
                viewState.emailState.validated = false
                viewState.emailState.message = "Invalid email format"
                signUpViewStateSubject.onNext(viewState)
            } else {
                viewState.emailState.validated = true
                viewState.emailState.message = nil
                signUpViewStateSubject.onNext(viewState)
            }
        } catch {
            
        }
    }
    
    func requestAuthCodeBy(email: String) {
        
        signRepository.signUpEmail(email: email)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onSubscribe: {
                    do {
                        var viewState = try
                            self.signUpViewStateSubject.value()
                        self.signUpViewStateSubject.onNext(viewState)
                    } catch {
                        
                    }
                }
            )
            .subscribe(
                onCompleted: {
                    do {
                        var viewState = try
                            self.signUpViewStateSubject.value()
                        self.signUpViewStateSubject.onNext(viewState)
                    } catch {}
                }, onError: { error in
                    do {
                        var viewState = try
                            self.signUpViewStateSubject.value()
                        self.signUpViewStateSubject.onNext(viewState)
                    } catch {}
                }
            )
            .disposed(by: disposeBag)
    }
    
}
