//
// Customer Product Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class CustomerProductTests: RizeSDKTests {
	func testList() async {
		do {
			let params = CustomerProductListParams(
				program_uid: "pQtTCSXz57fuefzp",
				product_uid: "zbJbEa72eKMgbbBv",
				customer_uid: "uKxmLxUEiSj5h4M3"
			)
			let response = try await RizeSDKTests.client?.customerProducts.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("CustomerProductTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = CustomerProductCreateParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				product_uid: "zbJbEa72eKMgbbBv"
			)
			let response = try await RizeSDKTests.client?.customerProducts.create(body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("CustomerProductTests.testCreate error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.customerProducts.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("CustomerProductTests.testGet error\n \(error)")
		}
	}
}
