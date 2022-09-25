// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonData",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CommonData",
            targets: ["CommonData"]
        )
    ],
    dependencies: [
        .package(path: "Domain")
    ],
    targets: [
        .target(
            name: "CommonData",
            dependencies: ["Domain"]
        ),
        .testTarget(
            name: "CommonDataTests",
            dependencies: ["CommonData"]
        )
    ]
)
