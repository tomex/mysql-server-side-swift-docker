// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sample",
    products: [
    ],
    dependencies: [
	   .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "1.7.9")),
	   .package(url: "https://github.com/IBM-Swift/SwiftKueryMySQL.git", .upToNextMinor(from: "0.13.2")),
	   .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1"))
    ],
    targets: [
		.target(
            name: "Sample",
            dependencies: ["Kitura", "SwiftKueryMySQL", "HeliumLogger"]),
        .testTarget(
            name: "SampleTests",
            dependencies: ["Sample"])
    ]
)
