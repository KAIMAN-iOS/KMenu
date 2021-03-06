// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KMenu",
    defaultLocalization: "en",
    platforms: [.iOS("13.0")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "KMenu",
            targets: ["KMenu"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/jonkykong/SideMenu", from: "6.5.0"),
        .package(url: "https://github.com/KAIMAN-iOS/KCoordinatorKit", .branch("master")),
        .package(url: "https://github.com/KAIMAN-iOS/KExtensions", .branch("master")),
        .package(url: "https://github.com/KAIMAN-iOS/ATAViews", .branch("master")),
        .package(url: "https://github.com/KAIMAN-iOS/ATAConfiguration", .branch("master")),
        .package(url: "https://github.com/evgenyneu/Cosmos", from: "23.0.0"),
        .package(url: "https://github.com/Minitour/EasyNotificationBadge", from: "1.2.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "KMenu",
            dependencies: ["SideMenu", "KCoordinatorKit", "ATAViews", "KExtensions", "ATAConfiguration", "Cosmos"])
    ]
)
