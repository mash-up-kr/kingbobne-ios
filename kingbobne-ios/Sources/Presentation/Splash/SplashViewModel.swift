//
//  SplashViewModle.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/09.
//

import Foundation
import RxSwift

protocol SplashViewModel {
    func refresh()
    
    func observeState() -> Single<SplashState>
}

class SplashViewModelCompanion {
    static func newInstance() -> SplashViewModel {
        let myProfileRepository = MyProfileRepositoryCompanion.getInstance()
        let signRepository = SignRepositoryCompanion.getInstance()
        return SplashViewModelImpl(
            signRepository: signRepository,
            myProfileRepository: myProfileRepository
        )
    }
}

class SplashViewModelImpl : SplashViewModel {
    private let stateSubject = PublishSubject<SplashState>()
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let myProfileRepository: MyProfileRepository
    private let signRepository: SignRepository
    
    init(
        signRepository: SignRepository,
        myProfileRepository: MyProfileRepository
    ) {
        self.myProfileRepository = myProfileRepository
        self.signRepository = signRepository
    }
    
    func refresh() {
        myProfileRepository.fetchMyProfile()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { myProfile in self.ifMyProfilePresent(myProfile: myProfile) }
            .subscribe(
                onSuccess: { myProfile in
                    self.stateSubject.onNext(SplashState.NAVIGATE_TO_HOME)
                },
                onFailure: { _ in
                    self.stateSubject.onNext(SplashState.NAVIGATE_TO_SIGN)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func observeState() -> Single<SplashState> {
        return stateSubject.firstOrError()
            .observe(on: MainScheduler.instance)
    }
    
    func ifMyProfilePresent(myProfile: UserProfile) -> Single<UserProfile> {
        if myProfile == UserProfile.EMPTY {
            return Single<UserProfile>.error(NSError.init())
        } else {
            return Single.just(myProfile)
        }
    }
}


