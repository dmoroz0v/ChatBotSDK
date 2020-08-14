// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChatBotSDK",
    products: [
        .library(
            name: "ChatBotSDK",
            targets: ["ChatBotSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.0.0")
    ],
    targets: [
        .target(
            name: "ChatBotSDK",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift"),
            ]
        ),
    ]
)
