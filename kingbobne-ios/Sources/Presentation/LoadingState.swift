//
//  LoadState.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/17.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

enum LoadingState<T> : Equatable {
    case initial
    case loading
    case success(data: T)
    case error(error: Error)
    
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial),
            (.loading, .loading),
            (.success, .success),
            (.error, .error):
            return true
        default:
            return false
        }
        
    }
    
}
