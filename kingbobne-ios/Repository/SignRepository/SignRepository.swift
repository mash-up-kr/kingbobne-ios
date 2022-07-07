//
//  SignRepository.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation

protocol SignRepository {
    
}

class SignRepositoryCompanion {
    static func newInstance(authService: AuthService = AuthCompanion.newInstance()) -> SignRepository {
        return SignRepositoryImpl(authService: authService)
    }
}

class SignRepositoryImpl: SignRepository {
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
}
