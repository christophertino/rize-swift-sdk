//
// Product Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class ProductTests: RizeSDKTests {
	func testList() async {
		do {
			let params = ProductListParams(
				program_uid: "pQtTCSXz57fuefzp"
			)
			let response = try await RizeSDKTests.client?.products.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("ProductTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.products.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("ProductTests.testGet error\n \(error)")
		}
	}
}
