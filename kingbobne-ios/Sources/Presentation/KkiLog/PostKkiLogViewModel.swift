//
//  PostKkiLogViewModel.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol PostKkiLogViewModel {
    func observeViewState() -> Observable<PostKkiLogViewState>
    
    func addPhoto(photo: URL)
    
    func setTitle(title: String)
    
    func setContent(content: String)
    
    func setKkiLogKick(kick: String)
    
    func upload()
}

class PostKkiLogViewModelCompanion {
    static func newInstance() -> PostKkiLogViewModel {
        return PostKkiLogViewModelImpl()
    }
}

fileprivate class PostKkiLogViewModelImpl: PostKkiLogViewModel {
    
    private static let MIN_TITLE_COUNT = 5
    private static let MIN_CONTENT_COUNT = 10
    private static let MIN_KICK_COUNT = 0
    
    private let viewStateRelay: BehaviorRelay<PostKkiLogViewState> = .init(value: PostKkiLogViewState.EMPTY)
    
    private let titleSubject: PublishSubject<String> = .init()
    private let contentSubject: PublishSubject<String> = .init()
    private let kickSubject: PublishSubject<String> = .init()
    
    private let disposeBag = DisposeBag()
    
    init() {
        publishUploadStateChanged()
    }
    
    private func publishUploadStateChanged() {
        Observable.combineLatest(titleSubject, contentSubject, kickSubject)
            .map { (title, content, kick) in
                (title.count >= PostKkiLogViewModelImpl.MIN_TITLE_COUNT) &&
                (content.count >= PostKkiLogViewModelImpl.MIN_CONTENT_COUNT) &&
                (kick.count >= PostKkiLogViewModelImpl.MIN_KICK_COUNT)
            }
            .subscribe(
                onNext: { uploadEnabled in
                    var state = self.viewStateRelay.value
                    state.uploadEnabled = uploadEnabled
                    self.viewStateRelay.accept(state)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func observeViewState() -> Observable<PostKkiLogViewState> {
        return viewStateRelay.distinctUntilChanged()
    }
    
    func addPhoto(photo: URL) {
        var state = viewStateRelay.value
        state.photos.append(photo)
        
        viewStateRelay.accept(state)
    }
    
    func setTitle(title: String) {
        titleSubject.onNext(title)
    }
    
    func setContent(content: String) {
        contentSubject.onNext(content)
    }
    
    func setKkiLogKick(kick: String) {
        kickSubject.onNext(kick)
    }
    
    func upload() {
        var state = self.viewStateRelay.value
        state.uploadState = LoadingState.loading
        self.viewStateRelay.accept(state)
        // TODO call upload api
    }
    
    
}
