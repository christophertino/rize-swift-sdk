//
// RizeSDK Package Init
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// RizeSDK is the top-level client containing all APIs and configurations
public struct RizeSDK {
	internal private(set) static var config: RizeConfig?
	internal var auth: Auth
	internal var customers: Customers

	public init(config: RizeConfig) {
		RizeSDK.config = config

		Utils.logger("Creating client")

		// Initialize API Services
		self.auth = Auth()
		self.customers = Customers()
	}
}
