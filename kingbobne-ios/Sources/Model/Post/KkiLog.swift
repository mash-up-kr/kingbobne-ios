//
//  Post.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation

struct KkiLog: Identifiable, Equatable {
    let id: String
    let photos: [URL]
    let title: String
    let content: String
    let kick: String?
    let bookmark: Bool
    let createdAt: Date
    
    static let EMPTY: KkiLog = .init(
        id: "",
        photos: [],
        title: "",
        content: "",
        kick: nil,
        bookmark: false,
        createdAt: Date.now
    )
}
