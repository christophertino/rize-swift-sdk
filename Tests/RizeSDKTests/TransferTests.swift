//
// Transfer Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class TransferTests: RizeSDKTests {
	func testList() async {
		do {
			let params = TransferListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				external_uid: "client-generated-id",
				pool_uid: "wTSMX1GubP21ev2h",
				synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				limit: 100,
				offset: 10
			)
			let response = try await RizeSDKTests.client?.transfers.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("TransferTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = TransferCreateParams(
				external_uid: "client-generated-id",
				source_synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				destination_synthetic_account_uid: "exMDShw6yM3NHLYV",
				initiating_customer_uid: "iDtmSA52zRhgN4iy",
				usd_transfer_amount: "12.34"
			)
			let response = try await RizeSDKTests.client?.transfers.create(body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("TransferTests.testCreate error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.transfers.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("TransferTests.testGet error\n \(error)")
		}
	}
}
