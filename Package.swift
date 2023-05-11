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
                      checksum: "0c549b3748444e4f118b9edc26c7a5152225d3c6876699bad81cb8450073ed6f")
    ]
)
