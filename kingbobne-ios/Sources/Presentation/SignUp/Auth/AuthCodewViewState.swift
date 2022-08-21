//
//  AuthCodewViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import SwiftUI

struct AuthCodeViewState {
    var authCodeLoadingState: LoadingState<Void> = LoadingState.initial
    var authCode: String = ""
    var btnEnabled: Bool {
        return !authCode.isEmpty
    }
    var email: String = ""
}
