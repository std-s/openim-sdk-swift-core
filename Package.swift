// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenIMSDKCoreSwift",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "OpenIMSDKCoreSwift",
            targets: ["OpenIMSDKCoreSwift"]),
    ],
    targets: [
        .target(
            name: "OpenIMSDKCoreSwift",
            dependencies: [
                .target(name: "CoreFramework")
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        ),
        .binaryTarget(name: "CoreFramework", path: "Framework/OpenIMSDKCore.xcframework"),
        .testTarget(
            name: "OpenIMSDKTests",
            dependencies: ["OpenIMSDKCoreSwift"]
        ),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)
