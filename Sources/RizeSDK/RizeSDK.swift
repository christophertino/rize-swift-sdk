//
// RizeSDK Package Init
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

/// RizeSDK is the top-level client containing all APIs and configurations
public struct RizeSDK {
	public private(set) var config: RizeConfig

	public init(config: RizeConfig) {
		self.config = config

		Utils.logger("Creating client...")

		// Validate client config
		// Initialize API Services
		// Generate Auth Token
	}
}
