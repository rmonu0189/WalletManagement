// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppUI",
            targets: ["AppUI"]
        )
    ],
    dependencies: [
        .package(path: "CommonUtility"),
        .package(path: "Domain")
    ],
    targets: [
        .target(
            name: "AppUI",
            dependencies: [
                "CommonUtility", "Domain"
            ]
        ),
        .testTarget(
            name: "AppUITests",
            dependencies: ["AppUI"]
        )
    ]
)
