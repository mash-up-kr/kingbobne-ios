//
//  SignUpViewModel.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/14.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

protocol SignUpViewModel {
    func validateEmail(email: String)
    func signUpEmail(email: String)
    func observeViewState() -> Observable<SignUpViewState>
}

class SignUpViewModelCompanion {
    static func newInstance() -> SignUpViewModel {
        let signRepository = SignRepositoryCompanion.getInstance()
        return SignUpViewModelImpl(signRepository: signRepository)
    }
}

fileprivate class SignUpViewModelImpl: SignUpViewModel {
    
    private static let REGEX_EMAIL = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let signRepository: SignRepository
    private let signUpViewStateSubject = BehaviorSubject<SignUpViewState>(value: SignUpViewState())
    
    init(signRepository: SignRepository) {
        self.signRepository = signRepository
    }
    
    func observeViewState() -> Observable<SignUpViewState> {
        return signUpViewStateSubject.distinctUntilChanged()
            .observe(on: MainScheduler.instance)
    }
    
    func validateEmail(email: String) {
        do {
            let regex = try NSRegularExpression(pattern: SignUpViewModelImpl.REGEX_EMAIL)
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
    
    func signUpEmail(email: String) {
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
