//
// RizeConfig
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// RizeConfig stores Rize configuration values
public struct RizeConfig {
	public var programUID: String?
	public var hmacKey: String?
	public var environment: RizeEnvironments?
	public var baseURL: String?
	public var userAgent: String

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

		guard environment != nil else {
			self.environment = RizeEnvironments.sandbox
			Utils.logger("Environment not recognized. Defaulting to Sandbox.")
			return
		}
		self.environment = environment
		self.baseURL = "https://\(self.environment?.getEnv() ?? "sandbox").rizefs.com/"

		let version = ProcessInfo.processInfo.operatingSystemVersion
		let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
		self.userAgent = String(format: "%@/%@ (OS Version: %@)", "rize-swift-sdk", Constants().SDK_VERSION, versionString)
	}
}

/// RizeEnvironments lists the development and production environments available to Rize clients.
public enum RizeEnvironments {
	case sandbox
	case integration
	case production

	func getEnv() -> String {
		switch self {
		case .sandbox:
			return "sandbox"
		case .integration:
			return "integration"
		case .production:
			return "production"
		}
	}
}

/// ConfigError handles RizeConfig property validation
public enum ConfigError: Error {
	case programUID
	case hmacKey
	case environment
}
