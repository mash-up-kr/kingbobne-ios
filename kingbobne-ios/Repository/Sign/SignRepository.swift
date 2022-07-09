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
    static let instance = SignRepositoryImpl(authService: AuthCompanion.newInstance())
    private init() { }
    static func getInstance() -> SignRepository {
        return instance
    }
}

class SignRepositoryImpl: SignRepository {
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
}
