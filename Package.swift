// swift-tools-version: 5.7

import PackageDescription

let package = Package(
	name: "RizeSDK",
	platforms: [
		.iOS(SupportedPlatform.IOSVersion.v15),
		.macOS(SupportedPlatform.MacOSVersion.v13)
	],
	products: [
		.library(
			name: "RizeSDK",
			targets: ["RizeSDK"])
	],
	dependencies: [
		.package(url: "https://github.com/realm/SwiftLint.git", from: "0.51.0")
	],
	targets: [
		.target(
			name: "RizeSDK",
			dependencies: [],
			plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]),
		.testTarget(
			name: "RizeSDKTests",
			dependencies: ["RizeSDK"],
			plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")])
	]
)
