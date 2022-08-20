//
//  SignRepository.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation
import RxSwift

protocol SignRepository {
    func signIn(email: String, password: String) -> Completable
    func isSignedIn() -> Single<Bool>
    func signUpEmail(email: String) -> Completable
}

class SignRepositoryCompanion {
    static let instance = SignRepositoryImpl(authService: AuthCompanion.newInstance())
    private init() { }
    static func getInstance() -> SignRepository {
        return instance
    }
}

internal class SignRepositoryImpl: SignRepository {
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn(email: String, password: String) -> Completable {
        return authService.signIn(email: email, password: password)
            .do(onSuccess: { accessToken in
                accessToken.save()
            })
            .asCompletable()
    }
    
    func isSignedIn() -> Single<Bool> {
        return Single.just(AccessToken.getOrNil() != nil)
    }
    
    func signUpEmail(email: String) -> Completable {
        return authService.validateEmail(email: email)
            .do(onCompleted: {
                print("signUpEmail - onCompleted")
                },
                    onSubscribe: {
                print("signUpEmail - onSubscribe")
                })
    }
    
}
