//
//  Dependencies.swift
//  Config
//
//  Created by victhor on 2022/07/10.
//
import ProjectDescription
import Foundation

public extension Package {
    
    static let rxSwift: Package = .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0"))
    static let moyaRxSwift: Package = .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0")
    static let lottieios: Package = .package(url: "https://github.com/airbnb/lottie-ios.git", from: "3.4.0")
    static let kingfisher: Package = .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0"))
    static let panModal: Package = .package(url: "https://github.com/slackhq/PanModal.git", .exact("1.2.6"))
}

//let dependencies = Dependencies(
//    swiftPackageManager: [
//        .remote(
//            url: "https://github.com/ReactiveX/RxSwift.git",
//            requirement: .upToNextMajor(from: "6.5.0")
//        ),
//        .remote(
//            url: "https://github.com/Moya/Moya.git",
//            requirement: .upToNextMajor(from: "15.0.0")
//        ),
//        .remote(
//            url: "https://github.com/airbnb/lottie-ios.git",
//            requirement: .upToNextMajor(from: "3.4.0")
//        )
//    ],
//    platforms: [.iOS]
//)


let dependencies = Dependencies(
    swiftPackageManager: [
        .rxSwift,
        .moyaRxSwift,
        .lottieios,
        .kingfisher,
        .panModal
    ],
    platforms: [.iOS]
)
