//
// Custodial Account Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class CustodialAccountTests: RizeSDKTests {
	func testList() async {
		do {
			let params = CustodialAccountListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				external_uid: "client-generated-id",
				limit: 100,
				offset: 10,
				liability: true,
				type: "dda"
			)
			let response = try await RizeSDKTests.client?.custodialAccounts.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("CustodialAccountTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.custodialAccounts.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("CustodialAccountTests.testGet error\n \(error)")
		}
	}
}
