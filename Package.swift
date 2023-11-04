// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChatBotSDK",
    products: [
        .library(
            name: "ChatBotSDK",
            targets: ["ChatBotSDK"]),
        .library(
            name: "TgBotSDK",
            targets: ["TgBotSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ChatBotSDK",
            dependencies: [
            ]
        ),
        .target(
            name: "TgBotSDK",
            dependencies: [
                "ChatBotSDK",
            ]
        ),
    ]
)
