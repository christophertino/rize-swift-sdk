//
// Transaction Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class TransactionTests: RizeSDKTests {
	func testList() async {
		do {
			let params = TransactionListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				pool_uid: "wTSMX1GubP21ev2h",
				debit_card_uid: "MYNGv45UK6HWBHHf",
				source_synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				destination_synthetic_account_uid: "exMDShw6yM3NHLYV",
				type: "card_refund",
				synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				show_denied_auths: true,
				show_expired: true,
				status: "failed",
				search_description: "Transfer%2A",
				include_zero: true,
				limit: 100,
				offset: 10,
				sort: "id_asc"
			)
			let response = try await RizeSDKTests.client?.transactions.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("TransactionTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.transactions.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("TransactionTests.testGet error\n \(error)")
		}
	}

	func testListTransactionEvents() async {
		do {
			let params = TransactionEventListParams(
				source_custodial_account_uid: "uKxmLxUEiSj5h4M3",
				destination_custodial_account_uid: "exMDShw6yM3NHLYV",
				custodial_account_uid: "MYNGv45UK6HWBHHf",
				type: "odfi_ach_withdrawal",
				transaction_uid: "4XkJnsfHsuqrxmeX",
				limit: 100,
				offset: 10,
				sort: "created_at_asc"
			)
			let response = try await RizeSDKTests.client?.transactions.listTransactionEvents(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("TransactionTests.testListTransactionEvents error\n \(error)")
		}
	}

	func testGetTransactionEvent() async {
		do {
			let response = try await RizeSDKTests.client?.transactions.getTransactionEvent(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("TransactionTests.testGetTransactionEvent error\n \(error)")
		}
	}

	func testListSyntheticLineItems() async {
		do {
			let params = SyntheticLineItemListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				pool_uid: "wTSMX1GubP21ev2h",
				synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				limit: 100,
				offset: 10,
				transaction_uid: "4XkJnsfHsuqrxmeX",
				status: "in_progress",
				sort: "created_at_asc"
			)
			let response = try await RizeSDKTests.client?.transactions.listSyntheticLineItems(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("TransactionTests.testListSyntheticLineItems error\n \(error)")
		}
	}

	func testGetSyntheticLineItem() async {
		do {
			let response = try await RizeSDKTests.client?.transactions.getSyntheticLineItem(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("TransactionTests.testGetSyntheticLineItem error\n \(error)")
		}
	}

	func testListCustodialLineItems() async {
		do {
			let params = CustodialLineItemListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				custodial_account_uid: "wTSMX1GubP21ev2h",
				status: "in_progress",
				us_dollar_amount_max: 2,
				us_dollar_amount_min: 2,
				transaction_event_uid: "MB2yqBrm3c4bUbou",
				transaction_uid: "4XkJnsfHsuqrxmeX",
				limit: 100,
				offset: 10,
				sort: "created_at_asc"
			)
			let response = try await RizeSDKTests.client?.transactions.listCustodialLineItems(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("TransactionTests.testListCustodialLineItems error\n \(error)")
		}
	}

	func testGetCustodialLineItem() async {
		do {
			let response = try await RizeSDKTests.client?.transactions.getCustodialLineItem(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("TransactionTests.testGetCustodialLineItem error\n \(error)")
		}
	}
}
