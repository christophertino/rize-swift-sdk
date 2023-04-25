//
// RizeSDKTests - XCTestCase Superclass
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

internal class RizeSDKTests: XCTestCase {
	internal static var client: RizeSDK?
	internal static var config: RizeConfig?

	/// Set up initial state for all test cases
	override class func setUp() {
		do {
			self.config = try RizeConfig(
				programUID: ProcessInfo.processInfo.environment["PROGRAM_UID"] ?? "programUID",
				hmacKey: ProcessInfo.processInfo.environment["HMAC_KEY"] ?? "hmacKey",
				environment: RizeEnvironments.local
			)
		} catch {
			Utils.logger("RizeConfig error: \(error)")
		}

		client = RizeSDK(config: self.config!)
	}
}
