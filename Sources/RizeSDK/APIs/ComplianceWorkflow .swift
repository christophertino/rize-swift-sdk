//
// Compliance Workflow API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct ComplianceWorkflow {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// Retrieves a list of Compliance Workflows filtered by the given parameters
	/// - Parameter query: WorkflowListParams
	/// - Returns: WorkflowList
	internal func list(query: WorkflowListParams) async throws -> WorkflowList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "compliance_workflows", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(WorkflowList.self, from: data)
	}

	/// Associates a new Compliance Workflow and set of Compliance Documents (for acknowledgment) with a Customer
	/// - Parameter body: Associates a new Compliance Workflow and set of Compliance Documents (for acknowledgment) with a Customer
	/// - Returns: Workflow
	internal func create(body: WorkflowCreateParams) async throws -> Workflow? {
		if body.customer_uid.isEmpty || body.product_compliance_plan_uid.isEmpty {
			throw HTTPServiceError.invalidBodyParameters(description: "customer_uid and product_compliance_plan_uid values are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "compliance_workflows", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Workflow.self, from: data)
	}

	/// ViewLatest is a helper endpoint for retrieving the most recent Compliance Workflow for a Customer.
	/// - Parameters:
	///   - customerUID: A UID referring to the Customer
	///   - query: WorkflowLatestParams
	/// - Returns: Workflow
	internal func viewLatest(customerUID: String, query: WorkflowLatestParams) async throws -> Workflow? {
		if customerUID.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "customerUID is required")
		}

		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "compliance_workflows/latest/\(customerUID)", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Workflow.self, from: data)
	}

	/// AcknowledgeDocument is used to indicate acceptance or rejection of a Compliance Document within a given Compliance Workflow
	/// - Parameters:
	///   - uid: Rize-generated unique id
	///   - body: WorkflowDocumentParams
	/// - Returns: Workflow
	internal func acknowledgeDocument(uid: String, body: WorkflowDocumentParams) async throws -> Workflow? {
		if uid.isEmpty || body.accept.isEmpty || body.document_uid.isEmpty || body.customer_uid.isEmptyOrNil {
			throw HTTPServiceError.invalidBodyParameters(description: "uid, accept, document_uid and customer_uid values are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "compliance_workflows/\(uid)/acknowledge_document", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Workflow.self, from: data)
	}

	/// BatchAcknowledgeDocuments is used to indicate acceptance or rejection of multiple Compliance Documents within a given Compliance Workflow
	/// - Parameters:
	///   - uid: Rize-generated unique id
	///   - body: WorkflowBatchDocumentsParams
	/// - Returns: Workflow
	internal func batchAcknowledgeDocuments(uid: String, body: WorkflowBatchDocumentsParams) async throws -> Workflow? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidBodyParameters(description: "uid is required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "compliance_workflows/\(uid)/batch_acknowledge_documents", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Workflow.self, from: data)
	}
}
