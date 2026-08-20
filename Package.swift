// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GCDWebServer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "GCDWebServer", targets: ["GCDWebServer"]),
        .library(name: "GCDWebUploader", targets: ["GCDWebUploader"]),
        .library(name: "GCDWebDAVServer", targets: ["GCDWebDAVServer"])
    ],
    targets: [
        .target(
            name: "GCDWebServer",
            path: "GCDWebServer",
            exclude: ["include"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("Core"),
                .headerSearchPath("Requests"),
                .headerSearchPath("Responses")
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedFramework("CoreServices"),
                .linkedFramework("CFNetwork")
            ]
        ),
        .target(
            name: "GCDWebUploader",
            dependencies: ["GCDWebServer"],
            path: "GCDWebUploader",
            exclude: ["include"],
            resources: [.copy("GCDWebUploader.bundle")],
            publicHeadersPath: "include",
            linkerSettings: [
                .linkedFramework("SystemConfiguration")
            ]
        ),
        .target(
            name: "GCDWebDAVServer",
            dependencies: ["GCDWebServer"],
            path: "GCDWebDAVServer",
            exclude: ["include"],
            publicHeadersPath: "include",
            linkerSettings: [
                .linkedLibrary("xml2")
            ]
        )
    ]
)
