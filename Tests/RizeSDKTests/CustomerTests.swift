//
// Customers Test
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

final class CustomerTests: RizeSDKTests {
	func testList() async {
		do {
			let params = CustomerListParams(
				limit: 20,
				offset: 0
			)
			let response = try await RizeSDKTests.client?.customers.list(query: params)
			XCTAssertNotNil(response?.count)
		} catch {
			Utils.logger(error.localizedDescription)
		}
	}
}
