//
//  PostKkiLogViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

struct PostKkiLogViewState : Equatable {
    var photos: [URL] = []
    var photoCount: Int {
        return photos.count
    }
    var kickCharacterLength: Int = 0
    var uploadEnabled: Bool = false
    var uploadState: LoadingState<KkiLog> = LoadingState.initial
    
    static let EMPTY = PostKkiLogViewState()
}
