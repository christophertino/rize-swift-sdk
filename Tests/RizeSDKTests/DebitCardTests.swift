//
// Debit Card Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class DebitCardTests: RizeSDKTests {
	func testList() async {
		do {
			let params = DebitCardListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				external_uid: "client-generated-id",
				limit: 100,
				offset: 10,
				pool_uid: "wTSMX1GubP21ev2h",
				locked: true,
				status: "queued"
			)
			let response = try await RizeSDKTests.client?.debitCards.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("DebitCardTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = DebitCardCreateParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				pool_uid: "wTSMX1GubP21ev2h",
				external_uid: "partner-generated-id",
				card_artwork_uid: "EhrQZJNjCd79LLYq",
				shipping_address: DebitCardShippingAddress(
					street1: "123 Abc St",
					street2: "Apt 2",
					city: "Chicago",
					state: "IL",
					postal_code: "12345"
				)
			)
			let response = try await RizeSDKTests.client?.debitCards.create(body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DebitCardTests.testCreate error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.debitCards.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DebitCardTests.testGet error\n \(error)")
		}
	}

	func testActivate() async {
		do {
			let params = DebitCardActivateParams(
				card_last_four_digits: "1234",
				cvv: "012",
				expiry_date: "2023-08"
			)
			let response = try await RizeSDKTests.client?.debitCards.activate(uid: "h9MzupcjtA3LPW2e", body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DebitCardTests.testActivate error\n \(error)")
		}
	}

	func testLock() async {
		do {
			let params = DebitCardLockParams(
				lock_reason: "Fraud detected"
			)
			let response = try await RizeSDKTests.client?.debitCards.lock(uid: "Lt6qjTNnYLjFfEWL", body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DebitCardTests.testLock error\n \(error)")
		}
	}

	func testUnlock() async {
		do {
			let response = try await RizeSDKTests.client?.debitCards.unlock(uid: "Lt6qjTNnYLjFfEWL")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DebitCardTests.testUnlock error\n \(error)")
		}
	}

	func testReissue() async {
		do {
			let params = DebitCardReissueParams(
				reissue_reason: "damaged",
				card_artwork_uid: "EhrQZJNjCd79LLYq",
				shipping_address: DebitCardShippingAddress(
					street1: "123 Abc St",
					street2: "Apt 2",
					city: "Chicago",
					state: "IL",
					postal_code: "12345"
				)
			)
			let response = try await RizeSDKTests.client?.debitCards.reissue(uid: "Lt6qjTNnYLjFfEWL", body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DebitCardTests.testReissue error\n \(error)")
		}
	}

	func testGetPINToken() async {
		do {
			let params = DebitCardGetPINTokenParams(
				force_reset: true
			)
			let response = try await RizeSDKTests.client?.debitCards.getPINToken(uid: "Lt6qjTNnYLjFfEWL", body: params)
			XCTAssertNotNil(response?.pin_change_token)
		} catch {
			Utils.logger("DebitCardTests.testGetPINToken error\n \(error)")
		}
	}

	func testGetAccessToken() async {
		do {
			let response = try await RizeSDKTests.client?.debitCards.getAccessToken(uid: "Lt6qjTNnYLjFfEWL")
			XCTAssertNotNil(response?.token)
		} catch {
			Utils.logger("DebitCardTests.testGetAccessToken error\n \(error)")
		}
	}

	func testMigrateVirtualDebitCard() async {
		do {
			let params = VirtualDebitCardMigrateParams(
				external_uid: "partner-generated-id",
				card_artwork_uid: "EhrQZJNjCd79LLYq",
				shipping_address: DebitCardShippingAddress(
					street1: "123 Abc St",
					street2: "Apt 2",
					city: "Chicago",
					state: "IL",
					postal_code: "12345"
				)
			)
			let response = try await RizeSDKTests.client?.debitCards.migrateVirtualDebitCard(uid: "Lt6qjTNnYLjFfEWL", body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DebitCardTests.testMigrateVirtualDebitCard error\n \(error)")
		}
	}

	func testGetVirtualDebitCardImage() async {
		do {
			let params = VirtualDebitCardQueryParams(
				token: "VmU27goFku4DyxfsdyoH5G1mlztvwskBywKrskVN9jQOh50Yy7",
				config: "1"
			)
			let response = try await RizeSDKTests.client?.debitCards.getVirtualDebitCardImage(query: params)
			XCTAssertEqual(200, response?.statusCode)
		} catch {
			Utils.logger("DebitCardTests.testGetVirtualDebitCardImage error\n \(error)")
		}
	}
}
