//
//  KkiLogArticleViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol KkiLogArticleViewModel {
    func observeViewState() -> Observable<KkiLogArticleViewState> 
    
    func bookmark()
    
    func cancelBookmark()
    
    func delete() -> Completable
}

class KkiLogArticleViewModelCompanion {
    static func newInstance() -> KkiLogArticleViewModel {
        return KkiLogArticleViewModelImpl()
    }
}

fileprivate class KkiLogArticleViewModelImpl: KkiLogArticleViewModel {
    
    private let viewStateRelay: BehaviorRelay<KkiLogArticleViewState> = .init(value: KkiLogArticleViewState.EMPTY)
    
    func observeViewState() -> Observable<KkiLogArticleViewState> {
        return viewStateRelay.distinctUntilChanged()
            .filter { state in
                state != KkiLogArticleViewState.EMPTY
            }
            .observe(on: MainScheduler.instance)
    }
    
    func bookmark() {
        var state = viewStateRelay.value
        if (state.bookmarkLoadingState == .loading) {
            return
        }
        
        state.bookmarkLoadingState = .loading
        viewStateRelay.accept(state)
        
        // TODO call api bookmark kkilog
    }
    
    func cancelBookmark() {
        var state = viewStateRelay.value
        if (state.bookmarkLoadingState == .loading) {
            return
        }
        
        state.bookmarkLoadingState = .loading
        // TODO call api cancel bookmark kkilog
    }
    
    func delete() -> Completable {
        var state = viewStateRelay.value
        if (state.deleteLoadingState == .loading) {
            return Completable.never()
        }
        
        state.deleteLoadingState = .loading
        // TODO call delete kkilog
        return Completable.empty()
    }
    
    
}
