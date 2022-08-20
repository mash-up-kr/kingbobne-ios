//
//  AuthCodeViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

class AuthCodeViewModel : ObservableObject {
    private let signUpRepository: SignUpRepository
    private let disposeBag: DisposeBag = DisposeBag()
    
    @Published var viewState: AuthCodeViewState = AuthCodeViewState()
    
    private let viewStateSubject = BehaviorSubject<AuthCodeViewState>(value: AuthCodeViewState())
    
    init() {
        self.signUpRepository = SignUpResitoryCompanion.getInstance()
        viewState.email = signUpRepository.getCachedEmail()
        viewStateSubject.onNext(viewState)
    }
    
    func observeViewState() -> Observable<AuthCodeViewState> {
        return viewStateSubject
    }
    
    func regenerateAuthCode() {
        signUpRepository.requestRegenerateAuthCode()
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func authenticate() {
        print("authenticate!!! auth code:" + viewState.authCode)
        signUpRepository.authenticateCode(code: viewState.authCode)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onSubscribed: {
                    self.viewState.authCodeLoadingState = LoadingState.loading
                    self.viewStateSubject.onNext(self.viewState)
                }
            )
            .subscribe(
                onCompleted: {
                    self.viewState.authCodeLoadingState = LoadingState.success(data: ())
                    self.viewStateSubject.onNext(self.viewState)
                },
                onError: { error in
                    self.viewState.authCodeLoadingState = LoadingState.error(error: error)
                    self.viewStateSubject.onNext(self.viewState)
                }
            )
            .disposed(by: disposeBag)
    }
    
}
