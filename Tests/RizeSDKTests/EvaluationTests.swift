//
// Evaluation Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class EvaluationTests: RizeSDKTests {
	func testList() async {
		do {
			let params = EvaluationListParams(
			customer_uid: "uKxmLxUEiSj5h4M3",
			latest: true
			)
			let response = try await RizeSDKTests.client?.evaluations.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("EvaluationTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.evaluations.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("EvaluationTests.testGet error\n \(error)")
		}
	}
}
