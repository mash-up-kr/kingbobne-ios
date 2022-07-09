//
//  UserRepository.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/09.
//

import Foundation
import RxSwift

protocol MyProfileRepository {
    func fetchMyProfile() -> Single<UserProfile>
    func observeMyProfile() -> Observable<UserProfile>
    func refresh()
}

class MyProfileRepositoryCompanion {
    static func newInstance() -> MyProfileRepository {
        return MyProfileRepositoryImpl()
    }
}

internal class MyProfileRepositoryImpl: MyProfileRepository {
    private let myProfileSubject = BehaviorSubject<UserProfile>(value: UserProfile.EMPTY)
    
    func fetchMyProfile() -> Single<UserProfile> {
        // fetch from services
        return Single.just(UserProfile.EMPTY)
    }
    
    func observeMyProfile() -> Observable<UserProfile> {
        return myProfileSubject
    }
    
    func refresh() {
        // refresh
    }
}
