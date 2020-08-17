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
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .exact("0.12.2")),
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
