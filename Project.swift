import ProjectDescription
import ProjectDescriptionHelpers

public extension Package {
    static let rxSwift: Package = .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0"))
    static let moyaRxSwift: Package = .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0")
    static let lottieios: Package = .package(url: "https://github.com/airbnb/lottie-ios.git", from: "3.4.0")
    static let kingfisher: Package = .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0"))
}

let project = Project(
    name: "kingbobne-ios",
    organizationName: "3999WG8MCQ",
    packages: [
        // spm package
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
        .rxSwift,
        .moyaRxSwift,
        .lottieios,
        .kingfisher
    ],
    settings: .settings(
        base: SettingsDictionary()
            // team account
            .automaticCodeSigning(devTeam: "3999WG8MCQ")
            .marketingVersion("1.0.0")
            .versionInfo("1.0.0")
            .currentProjectVersion("1"),
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    ),
    targets: [
        .init(
            name: "kingbobne-ios",
            platform: .iOS,
            product: .app,
            // organization name 이 변경되면 여기도 변경되어야함
            bundleId: "bigstark.kingbobne",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            infoPlist: "kingbobne-ios/Info.plist",
            sources: .init(globs: [
                "kingbobne-ios/Sources/**",
            ]),
            resources: .init(resources: [
                "kingbobne-ios/Resources/**"
            ]),
//            copyFiles: <#T##[CopyFilesAction]?#>,
            headers: nil,
//            entitlements: <#T##Path?#>,
//            scripts: <#T##[TargetScript]#>,
            dependencies: [
                // spm package name
                .package(product: "RxSwift"),
                .package(product: "RxCocoa"),
                .package(product: "RxRelay"),
                .package(product: "Moya"),
                .package(product: "RxMoya"),
                .package(product: "Lottie"),
            ]
//            settings: .settings(
//                base: <#T##SettingsDictionary#>,
//                debug: <#T##SettingsDictionary#>,
//                release: <#T##SettingsDictionary#>,
//                defaultSettings: <#T##DefaultSettings#>
//            ),
//            coreDataModels: [CoreDataModel],
//            environment: <#T##[String : String]#>,
//            launchArguments: <#T##[LaunchArgument]#>,
//            additionalFiles: []
        )
    ]
//    schemes: <#T##[Scheme]#>,
//    fileHeaderTemplate: <#T##FileHeaderTemplate?#>,
//    additionalFiles: <#T##[FileElement]#>,
//    resourceSynthesizers: [.]
)
