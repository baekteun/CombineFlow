// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineFlow",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "CombineFlow",
            targets: ["CombineFlow"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CombineFlow",
            dependencies: []
        ),
        .testTarget(
            name: "CombineFlowTests",
            dependencies: ["CombineFlow"]
        )
    ]
)
