//
// Pinwheel Job Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class PinwheelJobTests: RizeSDKTests {
	func testList() async {
		do {
			let params = PinwheelJobListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				limit: 100,
				offset: 10
			)
			let response = try await RizeSDKTests.client?.pinwheelJobs.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("PinwheelJobTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = PinwheelJobCreateParams(
				job_names: ["direct_deposit_switch"],
				synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				amount: 1000,
				disable_partial_switch: true,
				organization_name: "Chipotle Mexican Grill, Inc.",
				skip_welcome_screen: true
			)
			let response = try await RizeSDKTests.client?.pinwheelJobs.create(body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("PinwheelJobTests.testCreate error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.pinwheelJobs.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("PinwheelJobTests.testGet error\n \(error)")
		}
	}
}
