// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Sejima",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "Sejima",
            targets: ["Sejima"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/MoveUpwards/Neumann.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Sejima",
            dependencies: ["Neumann"],
            path: "Sejima/Sources"
        ),
    ]
)
