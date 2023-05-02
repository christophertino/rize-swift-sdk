//
// Pool Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class PoolTests: RizeSDKTests {
	func testList() async {
		do {
			let params = PoolListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				external_uid: "client-generated-id",
				limit: 100,
				offset: 10
			)
			let response = try await RizeSDKTests.client?.pools.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("PoolTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.pools.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("PoolTests.testGet error\n \(error)")
		}
	}
}
