// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        )
    ],
    dependencies: [
        .package(path: "Domain"),
        .package(path: "CommonUtility")
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: ["Domain", "CommonUtility"]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"]
        )
    ]
)
