//
// Auth Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

final class Auth: RizeSDKTests {
	func testGetToken() async {
		do {
			let response = try await RizeSDKTests.client?.auth.getToken()
			XCTAssertNotNil(response?.token)
		} catch {
			Utils.logger(error.localizedDescription)
		}
	}
}
