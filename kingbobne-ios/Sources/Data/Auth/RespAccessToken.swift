//
//  RespAccessToken.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/26.
//

import Foundation

internal struct RespAccessToken: Codable {
    let token: String
    let expiresIn: Int
    let refreshToken: String
}
