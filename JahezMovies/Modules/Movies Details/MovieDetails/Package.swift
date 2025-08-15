// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetails",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MovieDetails",
            targets: ["MovieDetails"]),
    ],
    dependencies: [
        .package(path: "GadoNetwork"),
        .package(path: "GeneralSwift")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MovieDetails",
            dependencies: [
                .product(name: "GadoNetwork", package: "GadoNetwork"),
                .product(name: "GeneralSwift", package: "GeneralSwift")
            ]),
        .testTarget(
            name: "MovieDetailsTests",
            dependencies: ["MovieDetails"]
        ),
    ]
)
