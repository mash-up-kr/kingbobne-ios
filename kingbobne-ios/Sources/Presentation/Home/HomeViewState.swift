//
//  HomeViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/30.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

struct HomeViewState : Equatable {
    let mealCount: Int = 0
    let characterStatus: CharacterStatus = CharacterStatus()
    
    static let EMPTY = HomeViewState()
}

struct CharacterStatus : Equatable {
    let name: String = ""
    let statusMessage: String = ""
    let characterUri: URL? = URL(string: "")
    let levelStatus: CharacterLevelStatus = CharacterLevelStatus()
}

struct CharacterLevelStatus : Equatable {
    let level: Int = 0
    let meta: Meta = Meta()
    
    struct Meta : Equatable {
        let progress: Int = 0
        let max: Int = 0
    }
}
