//
//  HomeViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol HomeViewModel {
    func observeViewState() -> Observable<HomeViewState>
}

class HomeViewModelCompanion {
    static func newInstance() -> HomeViewModel {
        return HomeViewModelImpl()
    }
}

fileprivate class HomeViewModelImpl : HomeViewModel {
    
    private let viewStateRelay = BehaviorRelay(value: HomeViewState())
    
    func observeViewState() -> Observable<HomeViewState> {
        return viewStateRelay.distinctUntilChanged()
            .filter { state in
                state != HomeViewState.EMPTY
            }
            .observe(on: MainScheduler.instance)
    }
    
    func feedChracter() {
        
    }
}
