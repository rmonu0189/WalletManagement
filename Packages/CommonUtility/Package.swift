// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonUtility",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CommonUtility",
            targets: ["CommonUtility"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CommonUtility",
            dependencies: []
        ),
        .testTarget(
            name: "CommonUtilityTests",
            dependencies: ["CommonUtility"]
        )
    ]
)
