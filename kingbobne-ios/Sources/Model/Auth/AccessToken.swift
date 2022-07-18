//
//  AccessToken.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation

struct AccessToken : Equatable {
    fileprivate static let KEY_ACCESS_TOKEN = "access-token"
    var token: String
    
    func save() {
        UserDefaults.standard.set(token, forKey: AccessToken.KEY_ACCESS_TOKEN)
    }
    
    static func getOrNil() -> AccessToken? {
        let token = UserDefaults.standard.string(forKey: AccessToken.KEY_ACCESS_TOKEN)
        return token != nil ? AccessToken(token: token!) : nil
    }
}
