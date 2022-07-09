//
//  SplashViewModle.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/09.
//

import Foundation
import RxSwift

protocol SplashViewModel {
    func observeState() -> Single<SplashState>
}

class SplashViewModelCompanion {
    static func newInstance() -> SplashViewModel {
        let myProfileRepository = MyProfileRepositoryCompanion.getInstance()
        return SplashViewModelImpl(myProfileRepository: myProfileRepository)
    }
}

class SplashViewModelImpl : SplashViewModel {
    private let myProfileRepository: MyProfileRepository
    private let stateSubject = PublishSubject<SplashState>()
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(myProfileRepository: MyProfileRepository) {
        self.myProfileRepository = myProfileRepository
        
        myProfileRepository.fetchMyProfile()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(
                onSuccess: { myProfile in
                    self.stateSubject.onNext(SplashState.NAVIGATE_TO_HOME)
                },
                onFailure: { _ in
                    self.stateSubject.onNext(SplashState.NAVIGATE_TO_LOGIN)
                }
            )
            .disposed(by: disposeBag)
        
        myProfileRepository.refresh()
    }
    
    func observeState() -> Single<SplashState> {
        return stateSubject.asSingle()
    }
}


