//
//  User.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation

struct UserProfile: Identifiable {
    let id: String
    
    static let EMPTY = UserProfile(id:"")
}
