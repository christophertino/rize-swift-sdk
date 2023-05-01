//
// Adjustments Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

final class AdjustmentTests: RizeSDKTests {
	func testList() async {
		do {
			let params = AdjustmentListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				adjustment_type_uid: "2Ej2tsFbQT3S1HYd",
				external_uid: "PT3sH7oxxQPwchrf",
				usd_adjustment_amount_max: 10,
				usd_adjustment_amount_min: 5,
				sort: "adjustment_type_name_asc"
			)
			let response = try await RizeSDKTests.client?.adjustments.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("AdjustmentTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = AdjustmentCreateParams(
				external_uid: "partner-generated-id",
				customer_uid: "kaxHFJnWvJxRJZxq",
				usd_adjustment_amount: "2.43",
				adjustment_type_uid: "KM2eKbR98t4tdAyZ"
			)
			let response = try await RizeSDKTests.client?.adjustments.create(body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("AdjustmentTests.testCreate error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.adjustments.get(uid: "exMDShw6yM3NHLYV")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("AdjustmentTests.testGet error\n \(error)")
		}
	}

	func testListAdjustmentTypes() async {
		do {
			let params = AdjustmentTypeListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				program_uid: "DbxJUHVuqt3C7hGK",
				show_deprecated: true
			)
			let response = try await RizeSDKTests.client?.adjustments.listAdjustmentTypes(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("AdjustmentTests.testListAdjustmentTypes error\n \(error)")
		}
	}

	func testGetAdjustmentType() async {
		do {
			let response = try await RizeSDKTests.client?.adjustments.getAdjustmentType(uid: "exMDShw6yM3NHLYV")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("AdjustmentTests.testGetAdjustmentType error\n \(error)")
		}
	}
}
