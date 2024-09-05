// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationToast",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "NotificationToast",
            targets: ["NotificationToast"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NotificationToast",
            dependencies: [],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        )
    ]
)
