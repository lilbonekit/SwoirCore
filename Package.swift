// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SwoirCore",
    products: [
        .library(
            name: "SwoirCore",
            targets: ["SwoirCore"]),
    ],
    targets: [
        .target(
            name: "SwoirCore"),
        .testTarget(
            name: "SwoirCoreTests",
            dependencies: ["SwoirCore"]),
    ]
)
