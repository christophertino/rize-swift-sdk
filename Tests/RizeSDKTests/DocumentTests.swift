//
// Document Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class DocumentTests: RizeSDKTests {
	func testList() async {
		do {
			let params = DocumentListParams(
				document_type: "monthly_statement",
				month: 1,
				year: 2020,
				custodial_account_uid: "yqyYk5b1xgXFFrXs",
				customer_uid: "uKxmLxUEiSj5h4M3",
				synthetic_account_uid: "4XkJnsfHsuqrxmeX",
				limit: 100,
				offset: 10
			)
			let response = try await RizeSDKTests.client?.documents.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("DocumentTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.documents.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("DocumentTests.testGet error\n \(error)")
		}
	}

	func testView() async {
		do {
			let response = try await RizeSDKTests.client?.documents.view(uid: "u8EHFJnWvJxRJZxa")
			XCTAssertEqual(200, response?.statusCode)
		} catch {
			Utils.logger("DocumentTests.testView error\n \(error)")
		}
	}
}
