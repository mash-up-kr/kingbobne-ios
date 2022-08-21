//
//  AuthCodewViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import SwiftUI

struct PasswordViewState {
    private static let MIN_PASSWORD = 8
    private static let MAX_PASSWORD = 15
    
    var password: String = ""
    var passwordValidation: String = ""
    var btnEnabled: Bool {
        return password == passwordValidation && (PasswordViewState.MIN_PASSWORD...PasswordViewState.MAX_PASSWORD).contains(password.count)
    }
    
    var passwordSaved: Bool = false
}

