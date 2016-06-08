import PackageDescription

let package = Package(
    name: "Resource",
    dependencies: [
        .Package(url: "https://github.com/Zewo/Router.git", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/Zewo/ContentNegotiationMiddleware.git", majorVersion: 0, minor: 6),
    ]
)
