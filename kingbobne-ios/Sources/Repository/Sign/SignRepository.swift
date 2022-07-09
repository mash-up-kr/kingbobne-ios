//
//  SignRepository.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation
import RxSwift

protocol SignRepository {
    func sample() -> Single<Array<ImageData>>
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
    
    func sample() -> Single<Array<ImageData>> {
        return authService.sample()
    }
    
}
