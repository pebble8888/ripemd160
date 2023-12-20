// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ripemd160",
    products: [
        .library(
            name: "ripemd160",
            targets: ["ripemd160"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ripemd160",
            path: "Sources"),
        .testTarget(
            name: "Ripemd160Tests",
            dependencies: ["ripemd160"], path: "Ripemd160Tests")
    ]
)
