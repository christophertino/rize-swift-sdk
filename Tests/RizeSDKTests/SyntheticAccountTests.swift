//
// Synthetic Account Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class SyntheticAccountTests: RizeSDKTests {
	func testList() async {
		do {
			let params = SyntheticAccountListParams(
				customer_uid: "uKxmLxUEiSj5h4M3",
				external_uid: "client-generated-id",
				pool_uid: "wTSMX1GubP21ev2h",
				limit: 100,
				offset: 10,
				synthetic_account_type_uid: "q4mdMxMtjXfdbrjn",
				synthetic_account_category: "general",
				liability: true,
				status: "active",
				sort: "name_asc"
			)
			let response = try await RizeSDKTests.client?.syntheticAccounts.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("SyntheticAccountTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = SyntheticAccountCreateParams(
				name: "New Resource Name",
				pool_uid: "kaxHFJnWvJxRJZxq",
				synthetic_account_type_uid: "fRMwt6H14ovFUz1s",
				external_uid: "partner-generated-id",
				account_number: "123456789012",
				routing_number: "123456789",
				plaid_processor_token: "processor-sandbox-96d86f35-ef58-4e4a-826f-4870b5d677f2",
				external_processor_token: "processor-sandbox-96d86f35-ef58-4e4a-826f-4870b5d677f2"
			)
			let response = try await RizeSDKTests.client?.syntheticAccounts.create(body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("SyntheticAccountTests.testCreate error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.syntheticAccounts.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("SyntheticAccountTests.testGet error\n \(error)")
		}
	}

	func testUpdate() async {
		do {
			let params = SyntheticAccountUpdateParams(
				name: "New Resource Name",
				note: "note"
			)
			let response = try await RizeSDKTests.client?.syntheticAccounts.update(uid: "EhrQZJNjCd79LLYq", body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("SyntheticAccountTests.testUpdate error\n \(error)")
		}
	}

	func testDelete() async {
		do {
			let response = try await RizeSDKTests.client?.syntheticAccounts.delete(uid: "EhrQZJNjCd79LLYq")
			XCTAssertTrue(response?.statusCode == 204)
		} catch {
			Utils.logger("SyntheticAccountTests.testDelete error\n \(error)")
		}
	}

	func testListAccountTypes() async {
		do {
			let params = SyntheticAccountTypeListParams(
				program_uid: "pQtTCSXz57fuefzp",
				limit: 100,
				offset: 0
			)
			let response = try await RizeSDKTests.client?.syntheticAccounts.listAccountTypes(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("SyntheticAccountTests.testListAccountTypes error\n \(error)")
		}
	}

	func testGetAccountType() async {
		do {
			let response = try await RizeSDKTests.client?.syntheticAccounts.getAccountType(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("SyntheticAccountTests.testGetAccountType error\n \(error)")
		}
	}
}
