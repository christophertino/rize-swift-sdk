//
// Customers Test
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

final class Customers: RizeSDKTests {
	func testList() async {
		do {
			let params = CustomerListParams(
				customer_type: "primary",
				email: "olive.oyl@rizemoney.com"
			)
			let response = try await RizeSDKTests.client?.customers.list(query: params)
			XCTAssertNotNil(response?.count)
		} catch {
			Utils.logger(error.localizedDescription)
		}
	}
}
