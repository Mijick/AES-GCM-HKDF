// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MijickGCM-HKDF",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "MijickGCM-HKDF",
            targets: ["MijickGCM-HKDF"]),
    ],
    targets: [
        .target(
            name: "MijickGCM-HKDF"),
        .testTarget(
            name: "MijickGCM-HKDFTests",
            dependencies: ["MijickGCM-HKDF"]
        ),
    ]
)
