//
//  RxExtensions.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/09.
//

import Foundation
import RxSwift

extension Observable {
    func firstOrError() -> Single<Element> {
        return Single.create { emitter -> Disposable in
            let disposable = self.subscribe(
                onNext: { element in
                    emitter(.success(element))
                },
                onError: { error in
                    emitter(.failure(error))
                }
            )
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
