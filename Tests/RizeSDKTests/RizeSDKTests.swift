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

	/// Set up initial state for all test cases
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

	func testAuth() async {
		do {
			let response = try await RizeSDKTests.client?.auth.getToken()
			XCTAssertNotNil(response?.token)
		} catch {
			Utils.logger(error.localizedDescription)
		}
	}

	func testRunner() throws {
	}
}
