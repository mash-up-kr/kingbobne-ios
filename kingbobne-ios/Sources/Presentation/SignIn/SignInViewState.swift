//
//  SignInViewState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/17.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

struct SignInViewState: Equatable {   
    var emailState: ValidationState = ValidationState()
    var passwordState: ValidationState = ValidationState()
    var emailPasswordValidated: Bool {
        return emailState.validated && passwordState.validated
    }
    var signInLoadingState: LoadingState<Void> = LoadingState.initial
}

struct ValidationState: Equatable {
    var validated: Bool = false
    var message: String? = nil
    
    static let VALIDATION_FORMAT_ERROR_MESSAGE = "Invalid Format"
}

