//
// Custodial Partner Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class CustodialPartnerTests: RizeSDKTests {
	func testList() async {
		do {
			let response = try await RizeSDKTests.client?.custodialPartners.list()
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("CustodialPartnerTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.custodialPartners.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("CustodialPartnerTests.testGet error\n \(error)")
		}
	}
}
