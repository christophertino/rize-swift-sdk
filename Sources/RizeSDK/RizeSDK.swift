//
// RizeSDK Package Init
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

/// RizeSDK is the top-level client containing all APIs and configurations
public struct RizeSDK {
	public private(set) var config: RizeConfig
	public var auth: Auth
	public var customers: Customers

	public init(config: RizeConfig) {
		self.config = config

		Utils.logger("Creating client...")

		// Initialize API Services
		self.auth = Auth(config: self.config)
		self.customers = Customers()

		// Generate Auth Token
		self.auth.getToken()
	}
}
