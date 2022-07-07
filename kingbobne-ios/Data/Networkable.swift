//
//  Networkable.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/26.
//

import Foundation
import Moya

protocol Networkable {
    associatedtype T: TargetType
    
    var provider: MoyaProvider<T> { get }
}
