// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Ripemd160",
    products: [
        .library(
            name: "Ripemd160",
            targets: ["Ripemd160"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Ripemd160",
            path: "Sources"),
        .testTarget(
            name: "Ripemd160Tests",
            dependencies: ["Ripemd160"], path: "Ripemd160Tests")
    ]
)
