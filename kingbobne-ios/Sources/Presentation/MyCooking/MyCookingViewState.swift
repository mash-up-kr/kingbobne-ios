//
//  MyCookingViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

struct MyCookingViewState : Equatable {
    var kkiLogItems: [KkiLog] = []
    var recipeItems: [Recipe] = []
    
    var kkiLogBookmarkLoadingState: LoadingState<KkiLog> = .initial
    var recipeBookmarkLoadingState: LoadingState<Recipe> = .initial
    
    static let EMPTY = MyCookingViewState()
}
