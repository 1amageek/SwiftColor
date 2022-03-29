// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftColor",
    platforms: [.iOS(.v15), .macOS(.v12), .watchOS(.v8)],
    products: [
        .library(
            name: "SwiftColor",
            targets: ["SwiftColor"]),
    ],
    targets: [
        .target(
            name: "SwiftColor",
            dependencies: []),
        .testTarget(
            name: "SwiftColorTests",
            dependencies: ["SwiftColor"]),
    ]
)
