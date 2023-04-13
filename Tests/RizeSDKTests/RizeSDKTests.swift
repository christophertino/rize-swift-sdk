//
// RizeSDKTests - Package Test Runner
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

final class RizeSDKTests: XCTestCase {
	private static var client: RizeSDK?
	private static var config: RizeConfig?

	/// Set up any overall initial state for all test cases
	override class func setUp() {
		do {
			self.config = try RizeConfig(
				programUID: ProcessInfo.processInfo.environment["PROGRAM_UID"],
				hmacKey: ProcessInfo.processInfo.environment["HMAC_KEY"],
				environment: RizeEnvironments.sandbox
			)
		} catch {
			Utils.logger("RizeConfig error: \(error)")
		}

		client = RizeSDK(config: self.config!)
	}

	func testRunner() throws {
	}
}
