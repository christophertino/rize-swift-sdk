//
// Customers Test
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
}
