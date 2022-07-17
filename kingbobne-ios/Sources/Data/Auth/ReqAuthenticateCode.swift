//
//  ReqAuthenticateCode.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/07/17.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import Foundation

struct ReqAuthenticateCode: Codable {
    let email: String
    let code: String
    let type: AuthCodeTypeDto
}
