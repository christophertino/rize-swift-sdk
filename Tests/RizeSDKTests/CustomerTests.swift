//
// Customer Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

final class CustomerTests: RizeSDKTests {
	func testList() async {
		do {
			let params = CustomerListParams(
				uid: "uKxmLxUEiSj5h4M3",
				status: "identity_verified",
				kyc_status: "denied",
				customer_type: "primary",
				first_name: "Olive",
				last_name: "Oyl",
				email: "olive.oyl@popeyes.com",
				program_uid: "pQtTCSXz57fuefzp",
				business_name: "Business inc",
				external_uid: "client-generated-id",
				pool_uid: "wTSMX1GubP21ev2h",
				sort: "first_name_asc",
				locked: false,
				include_initiated: true,
				limit: 100,
				offset: 0
			)
			let response = try await RizeSDKTests.client?.customers.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("CustomerTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = CustomerCreateParams(
				customer_type: "primary",
				primary_customer_uid: "kbF5TGrmwGizQuzZ",
				external_uid: "client-generated-id",
				email: "olive.oyl@popeyes.com",
				details: CustomerDetails(
					first_name: "Olive",
					middle_name: "Olivia",
					last_name: "Oyl",
					suffix: "Jr.",
					phone: "5555551212",
					business_name: "Oliver's Olive Emporium",
					dob: "2000-01-01",
					ssn: "111-22-3333",
					address: CustomerAddress(
						street1: "123 Abc St.",
						street2: "Apt 2",
						city: "Chicago",
						state: "IL",
						postal_code: "12345"
					)
				)
			)
			let response = try await RizeSDKTests.client?.customers.create(body: params)
			XCTAssertNotNil(response?.details)
		} catch {
			Utils.logger("CustomerTests.testCreate error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.customers.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.details)
		} catch {
			Utils.logger("CustomerTests.testGet error\n \(error)")
		}
	}

	func testUpdate() async {
		do {
			let params = CustomerUpdateParams(
				email: "olive.oyl@popeyes.com",
				details: CustomerDetails(
					first_name: "Olive",
					middle_name: "Olivia",
					last_name: "Oyl",
					suffix: "Jr.",
					phone: "5555551212",
					business_name: "Oliver's Olive Emporium",
					dob: "2000-01-01",
					ssn: "111-22-3333",
					ssn_last_four: "3333",
					address: CustomerAddress(
						street1: "123 Abc St.",
						street2: "Apt 2",
						city: "Chicago",
						state: "IL",
						postal_code: "12345"
					)
				),
				external_uid: "client-generated-id"
			)
			let response = try await RizeSDKTests.client?.customers.update(uid: "EhrQZJNjCd79LLYq", body: params)
			XCTAssertNotNil(response?.details)
		} catch {
			Utils.logger("CustomerTests.testUpdate error\n \(error)")
		}
	}

	func testDelete() async {
		do {
			let params = CustomerDeleteParams(archive_note: "Archiving customer note")
			let response = try await RizeSDKTests.client?.customers.delete(uid: "EhrQZJNjCd79LLYq", body: params)
			XCTAssertTrue(response?.statusCode == 204)
		} catch {
			Utils.logger("CustomerTests.testDelete error\n \(error)")
		}
	}

	func testConfirmPIIData() async {
		do {
			let response = try await RizeSDKTests.client?.customers.confirmPIIData(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.details)
		} catch {
			Utils.logger("CustomerTests.testConfirmPIIData error\n \(error)")
		}
	}

	func testLock() async {
		do {
			let params = CustomerLockParams(lock_note: "Fraud detected", lock_reason: "Customer Reported Fraud")
			let response = try await RizeSDKTests.client?.customers.lock(uid: "EhrQZJNjCd79LLYq", body: params)
			XCTAssertNotNil(response?.details)
		} catch {
			Utils.logger("CustomerTests.testLock error\n \(error)")
		}
	}

	func testUnlock() async {
		do {
			let params = CustomerLockParams(lock_note: "Fraud detected", lock_reason: "Customer Reported Fraud")
			let response = try await RizeSDKTests.client?.customers.unlock(uid: "EhrQZJNjCd79LLYq", body: params)
			XCTAssertNotNil(response?.details)
		} catch {
			Utils.logger("CustomerTests.testUnlock error\n \(error)")
		}
	}

	func testUpdateProfileResponses() async {
		do {
			let params = CustomerProfileResponseParams(
				profile_requirement_uid: "ptRLF7nQvy8VoqM1",
				profile_response: "Response string"
			)
			let response = try await RizeSDKTests.client?.customers.updateProfileResponses(uid: "EhrQZJNjCd79LLYq", body: [params])
			XCTAssertNotNil(response?.details)
		} catch {
			Utils.logger("CustomerTests.testUpdateProfileResponses error\n \(error)")
		}
	}
}
