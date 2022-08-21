//
//  NicknameViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/21.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

class NicknameViewModel : ObservableObject {
    
    private let signUpRepository: SignUpRepository
    private let disposeBag: DisposeBag = DisposeBag()
    
    @Published var viewState: NicknameViewState = NicknameViewState()
    private let viewStateSubject = BehaviorSubject<NicknameViewState>(value: NicknameViewState())
    private let validateNicknameSubject = PublishSubject<String>()
    
    private var nicknameValidationDisposable: Disposable? = nil
    
    init() {
        self.signUpRepository = SignUpResitoryCompanion.getInstance()
        self.validateNicknameSubject.distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter { nickname in
                self.viewState.nicknameLengthEnabled
            }
            .subscribe(
                onNext: { nickname in
                    self.validateNicknameInternal(nickname: nickname)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func validateNicknameInternal(nickname: String) {
        nicknameValidationDisposable?.dispose()
        nicknameValidationDisposable = self.signUpRepository.validateNickname(nickname: nickname)
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(
                onCompleted: {
                    self.viewState.nicknameValidationState.validated = true
                },
                onError: { error in
                    self.viewState.nicknameValidationState.validated = false
                    self.viewState.nicknameValidationState.message = "사용 중인 닉네임입니다."
                }
            )
    }
    
    func validateNickname(nickname: String) {
        validateNicknameSubject.onNext(nickname)
    }
    
    func observeSignUpLoadingState() -> Observable<LoadingState<Void>> {
        return viewStateSubject.map { viewState in
            viewState.signUpLoadingState
        }
    }
    
    func signUp() {
        signUpRepository.signUp(nickname: viewState.nickname)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onSubscribed: {
                    self.viewState.signUpLoadingState = LoadingState.loading
                    self.viewStateSubject.onNext(self.viewState)
                }
            )
            .subscribe(
                onCompleted: {
                    print("success to sign up")
                    self.viewState.signUpLoadingState = LoadingState.success(data: ())
                    self.viewStateSubject.onNext(self.viewState)
                },
                onError: { error in
                    self.viewState.signUpLoadingState = LoadingState.error(error: error)
                    self.viewStateSubject.onNext(self.viewState)
                }
            )
            .disposed(by: disposeBag)
    }
    
}


