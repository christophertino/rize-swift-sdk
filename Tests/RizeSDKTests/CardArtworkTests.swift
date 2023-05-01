//
// Card Artwork Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import XCTest
@testable import RizeSDK

final class CardArtworkTests: RizeSDKTests {
	func testList() async {
		do {
			let params = CardArtworkListParams(
				program_uid: "DbxJUHVuqt3C7hGK",
				limit: 100,
				offset: 10
			)
			let response = try await RizeSDKTests.client?.cardArtworks.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("CardArtworkTests.testList error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.cardArtworks.get(uid: "EhrQZJNjCd79LLYq")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("CardArtworkTests.testGet error\n \(error)")
		}
	}
}
