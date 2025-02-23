// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mijick-AES-GCM-HKDF",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "Mijick-AES-GCM-HKDF",
            targets: ["Mijick-AES-GCM-HKDF"]),
    ],
    targets: [
        .target(
            name: "Mijick-AES-GCM-HKDF"),
        .testTarget(
            name: "Mijick-AES-GCM-HKDFTests",
            dependencies: ["Mijick-AES-GCM-HKDF"]
        ),
    ]
)
