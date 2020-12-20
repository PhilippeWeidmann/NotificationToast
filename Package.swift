// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationToast",
    platforms: [
                .iOS(.v9),
            ],
    products: [
        .library(
            name: "NotificationToast",
            targets: ["NotificationToast"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NotificationToast",
            dependencies: [])
    ]
)
