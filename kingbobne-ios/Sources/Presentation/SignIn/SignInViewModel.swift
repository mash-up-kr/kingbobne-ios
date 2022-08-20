//
//  SignInViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/17.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

protocol SignInViewModel {
    func signIn(email: String, password: String)
    
    func observeViewState() -> Observable<SignInViewState>
    
    func validateEmail(email: String)
    
    func validatePassword(password: String)
}

class SignInViewModelCompanion {
    static func newInstance() -> SignInViewModel {
        let signRepository = SignRepositoryCompanion.getInstance()
        return SignInViewModelImpl(signRepository: signRepository)
    }
}

fileprivate class SignInViewModelImpl : SignInViewModel {
    private static let MIN_PASSWORD = 8
    private static let MAX_PASSWORD = 24
    private static let REGEX_EMAIL = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let signRepository: SignRepository
    private let signInViewStateSubject = BehaviorSubject<SignInViewState>(value: SignInViewState())
    
    init(signRepository: SignRepository) {
        self.signRepository = signRepository
    }
    
    func signIn(email: String, password: String) {
        signRepository.signIn(email: email, password: password)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onSubscribed: {
                    do {
                        var viewState = try self.signInViewStateSubject.value()
                        viewState.signInLoadingState = LoadingState.loading
                        self.signInViewStateSubject.onNext(viewState)
                    } catch {
                        
                    }
                }
            )
            .subscribe(
                onCompleted: {
                    do {
                        var viewState = try self.signInViewStateSubject.value()
                        viewState.signInLoadingState = LoadingState.success(data: ())
                        self.signInViewStateSubject.onNext(viewState)
                    } catch {}
                },
                onError: { error in
                    do {
                        var viewState = try self.signInViewStateSubject.value()
                        viewState.signInLoadingState = LoadingState.error(error: error)
                        self.signInViewStateSubject.onNext(viewState)
                    } catch {}
                }
            )
            .disposed(by: disposeBag)
    }
    
    func observeViewState() -> Observable<SignInViewState> {
        return signInViewStateSubject.distinctUntilChanged()
            .observe(on: MainScheduler.instance)
    }
    
    func validateEmail(email: String) {
        do {
            let regex = try NSRegularExpression(pattern: SignInViewModelImpl.REGEX_EMAIL)
            let results = regex.matches(in: email, range: NSRange(location: 0, length: email.count))
            var viewState = try self.signInViewStateSubject.value()
            if (results.isEmpty) {
                viewState.emailState.validated = false
                viewState.emailState.message = ValidationState.VALIDATION_FORMAT_ERROR_MESSAGE
                signInViewStateSubject.onNext(viewState)
            } else {
                viewState.emailState.validated = true
                viewState.emailState.message = nil
                signInViewStateSubject.onNext(viewState)
            }
        } catch {
            
        }
    }
    
    func validatePassword(password: String) {
        do {
            let isValidated = (SignInViewModelImpl.MIN_PASSWORD...SignInViewModelImpl.MAX_PASSWORD).contains(password.count)
            var viewState = try self.signInViewStateSubject.value()
            if isValidated {
                viewState.passwordState.validated = true
                viewState.passwordState.message = nil
                signInViewStateSubject.onNext(viewState)
            } else {
                viewState.passwordState.validated = false
                if (password.isEmpty) {
                    viewState.passwordState.message = ValidationState.VALIDATION_FORMAT_ERROR_MESSAGE
                } else if (password.count < SignInViewModelImpl.MIN_PASSWORD) {
                    viewState.passwordState.message = "최소 " + String(SignInViewModelImpl.MIN_PASSWORD) + "글자가 필요합니다."
                } else {
                    viewState.passwordState.message = "최대 " + String(SignInViewModelImpl.MAX_PASSWORD) + "글자가 필요합니다."
                }
                
                signInViewStateSubject.onNext(viewState)
            }
        } catch {
            
        }
    }
    
    
}
