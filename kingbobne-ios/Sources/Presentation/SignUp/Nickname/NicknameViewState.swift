//
//  NicknameViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/21.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import SwiftUI

struct NicknameViewState {
    private static let MIN_NICKNAME = 2
    private static let MAX_NICKNAME = 10
    
    var nickname: String = ""
    var btnEnabled: Bool {
        return !isErrorState() && nicknameLengthEnabled
    }
    
    var nicknameLength: Int {
        return nickname.count
    }
    
    var nicknameLengthEnabled: Bool {
        return (NicknameViewState.MIN_NICKNAME...NicknameViewState.MAX_NICKNAME).contains(nickname.count)
    }
    
    func isErrorState() -> Bool {
        return signUpLoadingState != .initial && signUpLoadingState != .loading && signUpLoadingState != .success(data: ())
    }
    
    var nicknameValidationState: ValidationState = ValidationState()
    
    var signUpLoadingState: LoadingState<Void> = LoadingState.initial
}

