//
//  MyCookingViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol MyCookingViewModel {
    func observeViewState() -> Observable<MyCookingViewState>
    
    func bookmark(item: KkiLog)
    
    func cancelBookmark(item: KkiLog)
    
    func bookmark(item: Recipe)
    
    func cancelBookmark(item: Recipe)
}

class MyCookingViewModelCompanion {
    static func newInstance() -> MyCookingViewModel {
        return MyCookingViewModelImpl()
    }
}

fileprivate class MyCookingViewModelImpl: MyCookingViewModel {
    private let viewStateRelay: BehaviorRelay<MyCookingViewState> = .init(value: .EMPTY)
    
    func observeViewState() -> Observable<MyCookingViewState> {
        return viewStateRelay.distinctUntilChanged()
            .observe(on: MainScheduler.instance)
    }
    
    func bookmark(item: KkiLog) {
        var state = viewStateRelay.value
        if (state.kkiLogBookmarkLoadingState == .loading) {
            return
        }
        state.kkiLogBookmarkLoadingState = .loading
        viewStateRelay.accept(state)
        
        // call bookmark api
    }
    
    func cancelBookmark(item: KkiLog) {
        var state = viewStateRelay.value
        if (state.kkiLogBookmarkLoadingState == .loading) {
            return
        }
        state.kkiLogBookmarkLoadingState = .loading
        viewStateRelay.accept(state)
        
        // call cancel bookmark api
    }
    
    func bookmark(item: Recipe) {
        var state = viewStateRelay.value
        if (state.recipeBookmarkLoadingState == .loading) {
            return
        }
        state.recipeBookmarkLoadingState = .loading
        viewStateRelay.accept(state)
        
        // call bookmark api
    }
    
    func cancelBookmark(item: Recipe) {
        var state = viewStateRelay.value
        if (state.recipeBookmarkLoadingState == .loading) {
            return
        }
        state.recipeBookmarkLoadingState = .loading
        viewStateRelay.accept(state)
        
        // call cancel bookmark api
    }
}
