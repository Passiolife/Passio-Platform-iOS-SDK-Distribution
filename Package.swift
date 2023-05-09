// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassioPlatformSDK",
    platforms: [.iOS(.v13)
    ],
    products: [
        .library(
            name: "PassioPlatformSDK",
            targets: ["PassioPlatformSDK"]),
    ],
    targets: [
        .binaryTarget(name: "PassioPlatformSDK",
                      url: "https://github.com/Passiolife/Passio-Platform-iOS-SDK-Distribution/raw/main/PassioPlatformSDK.xcframework.zip",
                      checksum: "e43b6ca3a96f644cb498dc94e646835a3196d15514d4bd8a1f2b9a717f6e60bc")
    ]
)
