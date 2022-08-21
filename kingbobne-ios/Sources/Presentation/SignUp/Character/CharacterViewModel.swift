//
//  AuthCodeViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/21.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

class CharacterViewModel : ObservableObject {
    private let signUpRepository: SignUpRepository
    private let disposeBag: DisposeBag = DisposeBag()
    
    @Published var viewState: CharacterViewState = CharacterViewState()
    
    private let viewStateSubject = BehaviorSubject<CharacterViewState>(value: CharacterViewState())
    
    init() {
        self.signUpRepository = SignUpResitoryCompanion.getInstance()
        viewState.characterType = signUpRepository.getCharacterType()
        viewStateSubject.onNext(viewState)
        
        Observable.just(())
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: {
                    self.viewState.characterVisible = true
                }
            )
            .disposed(by: disposeBag)
    }
    
    func observeStartState() -> Observable<Bool> {
        return viewStateSubject.map { viewState in
            viewState.startClicked
        }
        .filter { startClicked in
            startClicked
        }
        .distinctUntilChanged()
    }
    
    func start() {
        viewState.startClicked = true
        viewStateSubject.onNext(viewState)
    }
}
