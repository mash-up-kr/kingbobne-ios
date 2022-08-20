//
//  PasswordViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

class PasswordViewModel : ObservableObject {
    private let signUpRepository: SignUpRepository
    private let disposeBag: DisposeBag = DisposeBag()
    
    @Published var viewState: PasswordViewState = PasswordViewState()
    
    private let viewStateSubject = BehaviorSubject<PasswordViewState>(value: PasswordViewState())
    
    init() {
        self.signUpRepository = SignUpResitoryCompanion.getInstance()
    }
    
    func observeViewState() -> Observable<PasswordViewState> {
        return viewStateSubject
    }
    
    
}
