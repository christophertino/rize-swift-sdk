//
// Sandbox Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class SandboxTests: RizeSDKTests {
	func testCreate() async {
		do {
			let params = SandboxCreateParams(
				transaction_type: "atm_withdrawal",
				customer_uid: "uKxmLxUEiSj5h4M3",
				debit_card_uid: "h9MzupcjtA3LPW2e",
				us_dollar_amount: 21.89,
				denial_reason: "insufficient_funds",
				mcc: "5200",
				merchant_location: "NEW YORK, NY",
				merchant_name: "Widgets Incorporated",
				merchant_number: "000067107015968",
				description: "test transaction"
			)
			let response = try await RizeSDKTests.client?.sandboxes.create(body: params)
			XCTAssertNotNil(response?.success)
		} catch {
			Utils.logger("SandboxTests.testCreate error\n \(error)")
		}
	}
}
