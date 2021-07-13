// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription


let package = Package(
    name: "ApodiniTemplate",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "WebService",
            targets: ["WebService"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Apodini/Apodini.git", .branch("feature-logging-new")),
        .package(url: "https://github.com/Apodini/swift-log-elk.git", .branch("develop")),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
    ],
    targets: [
        .target(
            name: "WebService",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "ApodiniWebSocket", package: "Apodini"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "ApodiniObserve", package: "Apodini"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "LoggingELK", package: "swift-log-elk")
            ]
        ),
        .testTarget(
            name: "WebServiceTests",
            dependencies: ["WebService"]
        )
    ]
)
