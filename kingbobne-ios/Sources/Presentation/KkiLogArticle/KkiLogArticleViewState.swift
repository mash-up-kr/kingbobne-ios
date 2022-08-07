//
//  KkiLogArticleViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

struct KkiLogArticleViewState: Equatable {
    var kkiLog: KkiLog
    var bookmarkLoadingState: LoadingState<Void> = .initial
    var deleteLoadingState: LoadingState<Void> = .initial
    
    static let EMPTY: KkiLogArticleViewState = .init(kkiLog: KkiLog.EMPTY)
}
