//
// RizeSDK Configuration
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// ConfigError handles RizeConfig property validation
public enum ConfigError: Error {
	case programUID
	case hmacKey
	case environment
}

/// RizeEnvironments lists the development and production environments available to Rize clients.
public enum RizeEnvironments {
	case local
	case sandbox
	case integration
	case production

	func getEnv() -> String {
		switch self {
			case .local:
				return "localhost"
			case .sandbox:
				return "sandbox"
			case .integration:
				return "integration"
			case .production:
				return "production"
		}
	}
}

/// RizeConfig stores Rize configuration values
public struct RizeConfig {
	public var programUID: String?
	public var hmacKey: String?
	public var environment: RizeEnvironments?

	internal var baseURL: String
	internal var userAgent: String

	// Validate client config properties
	public init(programUID: String?, hmacKey: String?, environment: RizeEnvironments?) throws {
		guard !programUID.isEmptyOrNil else {
			throw ConfigError.programUID
		}
		self.programUID = programUID

		guard !hmacKey.isEmptyOrNil else {
			throw ConfigError.hmacKey
		}
		self.hmacKey = hmacKey

		if environment == nil {
			self.environment = RizeEnvironments.sandbox
			Utils.logger("Environment not recognized. Defaulting to Sandbox.")
		} else {
			self.environment = environment
		}

		self.baseURL = "\(self.environment?.getEnv() ?? "sandbox").rizefs.com"

		let version = ProcessInfo.processInfo.operatingSystemVersion
		let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
		self.userAgent = String(format: "%@/%@ (OS Version: %@)", "rize-swift-sdk", Constants().SDKVersion, versionString)
	}
}
