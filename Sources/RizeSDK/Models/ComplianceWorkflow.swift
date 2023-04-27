//
// ComplianceWorkflow Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// WorkflowList is an API response containing a list of Compliance Workflows
public struct WorkflowList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Workflow]?
}

/// Workflow data type
public struct Workflow: Decodable {
	let uid, product_uid, product_compliance_plan_uid: String?
	let summary: WorkflowSummary?
	let customer: WorkflowCustomer?
	let accepted_documents: [WorkflowAcceptedDocument]?
	let current_step_documents_pending: [WorkflowPendingDocument]?
	let all_documents: [WorkflowDocument]?
}

/// WorkflowSummary contains a status summary of the Compliance Workflow
public struct WorkflowSummary: Decodable {
	let accepted_quantity, completed_step, current_step: Int?
	let begun_at: Date?
	let status: String?
}

/// WorkflowCustomer contains Customer information related to this Compliance Workflow
public struct WorkflowCustomer: Decodable {
	let email, external_uid, uid: String?
}

/// WorkflowAcceptedDocument contains information about accepted Compliance Workflow documents
public struct WorkflowAcceptedDocument: Decodable {
	let electronic_signature_required,
		external_storage_name,
		compliance_document_url,
		name,
		uid: String?
	let step, version: Int?
	let accepted_at: Date?
}

/// WorkflowPendingDocument contains information about pending Compliance Workflow documents
public struct WorkflowPendingDocument: Decodable {
	let electronic_signature_required,
		external_storage_name,
		compliance_document_url,
		name,
		uid: String?
	let step, version: Int?
}

/// WorkflowDocument contains information about all Compliance Workflow documents
public struct WorkflowDocument: Decodable {
	let electronic_signature_required,
		external_storage_name,
		compliance_document_url,
		name: String?
	let step, version: Int?
}

/// WorkflowListParams builds the query parameters used in querying Compliance Workflows
public struct WorkflowListParams: Codable {
	var customer_uid: String? = nil
	var product_uid: String? = nil
	var in_progress: Bool? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

/// WorkflowLatestParams builds the query parameters used in querying the latest Compliance Workflow for a customer
public struct WorkflowLatestParams: Codable {
	var product_compliance_plan_uid: String? = nil
}

/// WorkflowCreateParams are the body params used when creating a new Compliance Workflow
public struct WorkflowCreateParams: Encodable {
	let customer_uid, product_compliance_plan_uid: String
}

/// WorkflowDocumentParams are the body params used when acknowledging a compliance document
public struct WorkflowDocumentParams: Encodable {
	let accept, document_uid: String
	var ip_address: String? = nil
	var user_name: String? = nil
	var customer_uid: String? = nil /// Required for AcknowledgeDocument but omitted for BatchAcknowledgeDocuments
}

/// WorkflowBatchDocumentsParams are the body params used when acknowledging multiple compliance documents
public struct WorkflowBatchDocumentsParams: Encodable {
	let customer_uid: String
	let documents: [WorkflowDocumentParams]
}

// swiftlint:enable identifier_name redundant_optional_initialization
