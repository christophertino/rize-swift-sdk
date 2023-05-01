//
// Compliance Workflow Tests
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

import XCTest
@testable import RizeSDK

final class ComplianceWorkflowTests: RizeSDKTests {
	func testList() async {
		do {
			let params = ComplianceWorkflowListParams(
				customer_uid: "S62MaHx6WwsqG9vQ",
				product_uid: "pQtTCSXz57fuefzp",
				in_progress: true,
				limit: 100,
				offset: 10
			)
			let response = try await RizeSDKTests.client?.complianceWorkflows.list(query: params)
			XCTAssertNotNil(response?.data)
		} catch {
			Utils.logger("ComplianceWorkflowTests.testList error\n \(error)")
		}
	}

	func testCreate() async {
		do {
			let params = ComplianceWorkflowCreateParams(
				customer_uid: "S62MaHx6WwsqG9vQ",
				product_compliance_plan_uid: "pQtTCSXz57fuefzp"
			)
			let response = try await RizeSDKTests.client?.complianceWorkflows.create(body: params)
			XCTAssertNotNil(response?.summary)
		} catch {
			Utils.logger("ComplianceWorkflowTests.testCreate error\n \(error)")
		}
	}

	func testViewLatest() async {
		do {
			let params = ComplianceWorkflowLatestParams(
				product_compliance_plan_uid: "pQtTCSXz57fuefzp"
			)
			let response = try await RizeSDKTests.client?.complianceWorkflows.viewLatest(customerUID: "h9MzupcjtA3LPW2e", query: params)
			XCTAssertNotNil(response?.summary)
		} catch {
			Utils.logger("ComplianceWorkflowTests.testViewLatest error\n \(error)")
		}
	}

	func testAcknowledgeDocument() async {
		do {
			let params = ComplianceWorkflowDocumentParams(
				accept: "yes",
				document_uid: "Yqyjk5b2xgQ9FrxS",
				ip_address: "107.56.230.156",
				user_name: "gilbert chesterton",
				customer_uid: "h9MzupcjtA3LPW2e"
			)
			let response = try await RizeSDKTests.client?.complianceWorkflows.acknowledgeDocument(uid: "h9MzupcjtA3LPW2e", body: params)
			XCTAssertNotNil(response?.summary)
		} catch {
			Utils.logger("ComplianceWorkflowTests.testAcknowledgeDocument error\n \(error)")
		}
	}

	func testBatchAcknowledgeDocuments() async {
		do {
			let params = ComplianceWorkflowBatchDocumentsParams(
				customer_uid: "h9MzupcjtA3LPW2e",
				documents: [ComplianceWorkflowDocumentParams(
					accept: "yes",
					document_uid: "Yqyjk5b2xgQ9FrxS",
					ip_address: "107.56.230.156",
					user_name: "gilbert chesterton",
					customer_uid: "h9MzupcjtA3LPW2e"
				), ComplianceWorkflowDocumentParams(
					accept: "yes",
					document_uid: "Yqyjk5b2xgQ9FrxS",
					customer_uid: "h9MzupcjtA3LPW2e"
				)]
			)
			let response = try await RizeSDKTests.client?.complianceWorkflows.batchAcknowledgeDocuments(uid: "h9MzupcjtA3LPW2e", body: params)
			XCTAssertNotNil(response?.summary)
		} catch {
			Utils.logger("ComplianceWorkflowTests.testBatchAcknowledgeDocuments error\n \(error)")
		}
	}
}
