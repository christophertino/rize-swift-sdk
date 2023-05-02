//
// KYC Document Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class KYCDocumentTests: RizeSDKTests {
	func testList() async {
		do {
			let params = KYCDocumentListParams(
				evaluation_uid: "QSskNJkryskRXeYt"
			)
			let response = try await RizeSDKTests.client?.kycDocuments.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("KYCDocumentTests.testList error\n \(error)")
		}
	}

	func testUpload() async {
		do {
			let params = KYCDocumentUploadParams(
				evaluation_uid: "QSskNJkryskRXeYt",
				filename: "fred_smith_license.png",
				file_content: "Base64Encoded string",
				note: "Uploaded via SDK",
				type: "license"
			)
			let response = try await RizeSDKTests.client?.kycDocuments.upload(body: params)
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("KYCDocumentTests.testUpload error\n \(error)")
		}
	}

	func testGet() async {
		do {
			let response = try await RizeSDKTests.client?.kycDocuments.get(uid: "u8EHFJnWvJxRJZxa")
			XCTAssertNotNil(response?.uid)
		} catch {
			Utils.logger("KYCDocumentTests.testGet error\n \(error)")
		}
	}

	func testView() async {
		do {
			let response = try await RizeSDKTests.client?.kycDocuments.view(uid: "u8EHFJnWvJxRJZxa")
			XCTAssertEqual(200, response?.statusCode)
		} catch {
			Utils.logger("KYCDocumentTests.testView error\n \(error)")
		}
	}
}
