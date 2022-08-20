//
//  DataWrapper.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/21.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

struct DataWrapper<T: Codable> : Codable {
    let data: T
}
