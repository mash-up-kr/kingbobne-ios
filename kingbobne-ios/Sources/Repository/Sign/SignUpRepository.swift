//
//  SignUpRepository.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation
import RxSwift

protocol SignUpRepository {
    func validateEmail(email: String) -> Completable
    func requestAuthCode(email: String) -> Completable
    func requestRegenerateAuthCode() -> Completable
    func authenticateCode(code: String) -> Completable
    func validateNickname(nickname: String) -> Completable
    
    func getCachedEmail() -> String
    func cachePassword(_ password: String)
    func clearPasswordCache()
}

class SignUpResitoryCompanion {
    private static let instance = SignUpRepositoryImpl(authService: AuthCompanion.newInstance())
    private init() { }
    static func getInstance() -> SignUpRepository {
        return instance
    }
}

fileprivate class SignUpRepositoryImpl: SignUpRepository {
    private let authService: AuthService
    private var cachedEmail: String = ""
    private var cachedPassword: String = ""
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func validateEmail(email: String) -> Completable {
        return authService.validateEmail(email: email)
    }
    
    func requestAuthCode(email: String) -> Completable {
        return authService.requestAuthCode(email: email, type: AuthCodeTypeDto.SIGN_UP)
            .do(onCompleted: {
                self.cachedEmail = email
            })
    }
    
    func requestRegenerateAuthCode() -> Completable {
        return authService.requestAuthCode(email: cachedEmail, type: AuthCodeTypeDto.SIGN_UP)
    }
    
    func authenticateCode(code: String) -> Completable {
        return authService.authenticateCode(email: cachedEmail, code: code, type: AuthCodeTypeDto.SIGN_UP)
    }
    
    func validateNickname(nickname: String) -> Completable {
        return authService.validateNickname(nickname: nickname)
    }
    
    func getCachedEmail() -> String {
        return cachedEmail
    }
    
    func cachePassword(_ password: String) {
        self.cachedPassword = password
    }
    
    func clearPasswordCache() {
        self.cachedPassword = ""
    }
}
