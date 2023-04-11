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
	public var baseURL = "https://sandbox.rizefs.com/"

	public init(programUID: String?, hmacKey: String?, environment: RizeEnvironments?) {
		guard self.programUID == programUID else {
			// error
			return
		}
		
	}
}

///RizeEnvironments lists the development and production environments available to Rize clients.
public enum RizeEnvironments {
	case Sandbox
	case Integration
	case Production

	func setEnv() -> String {
		switch self {
			case .Sandbox:
				return "sandbox"
			case .Integration:
				return "integration"
			case .Production:
				return "production"
		}
	}
}
