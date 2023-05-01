//
// ComplianceWorkflow Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// ComplianceWorkflowList is an API response containing a list of Compliance Workflows
public struct ComplianceWorkflowList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [ComplianceWorkflow]?
}

/// ComplianceWorkflow data type
public struct ComplianceWorkflow: Decodable {
	let uid, product_uid, product_compliance_plan_uid: String?
	let summary: ComplianceWorkflowSummary?
	let customer: ComplianceWorkflowCustomer?
	let accepted_documents: [ComplianceWorkflowAcceptedDocument]?
	let current_step_documents_pending: [ComplianceWorkflowPendingDocument]?
	let all_documents: [ComplianceWorkflowDocument]?
}

/// ComplianceWorkflowSummary contains a status summary of the Compliance Workflow
public struct ComplianceWorkflowSummary: Decodable {
	let accepted_quantity, completed_step, current_step: Int?
	let begun_at: Date?
	let status: String?
}

/// ComplianceWorkflowCustomer contains Customer information related to this Compliance Workflow
public struct ComplianceWorkflowCustomer: Decodable {
	let email, external_uid, uid: String?
}

/// ComplianceWorkflowAcceptedDocument contains information about accepted Compliance Workflow documents
public struct ComplianceWorkflowAcceptedDocument: Decodable {
	let electronic_signature_required,
		external_storage_name,
		compliance_document_url,
		name,
		uid: String?
	let step, version: Int?
	let accepted_at: Date?
}

/// ComplianceWorkflowPendingDocument contains information about pending Compliance Workflow documents
public struct ComplianceWorkflowPendingDocument: Decodable {
	let electronic_signature_required,
		external_storage_name,
		compliance_document_url,
		name,
		uid: String?
	let step, version: Int?
}

/// ComplianceWorkflowDocument contains information about all Compliance Workflow documents
public struct ComplianceWorkflowDocument: Decodable {
	let electronic_signature_required,
		external_storage_name,
		compliance_document_url,
		name: String?
	let step, version: Int?
}

/// ComplianceWorkflowListParams builds the query parameters used in querying Compliance Workflows
public struct ComplianceWorkflowListParams: Encodable {
	var customer_uid: String? = nil
	var product_uid: String? = nil
	var in_progress: Bool? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

/// ComplianceWorkflowLatestParams builds the query parameters used in querying the latest Compliance Workflow for a customer
public struct ComplianceWorkflowLatestParams: Encodable {
	var product_compliance_plan_uid: String? = nil
}

/// ComplianceWorkflowCreateParams are the body params used when creating a new Compliance Workflow
public struct ComplianceWorkflowCreateParams: Encodable {
	let customer_uid, product_compliance_plan_uid: String
}

/// ComplianceWorkflowDocumentParams are the body params used when acknowledging a compliance document
public struct ComplianceWorkflowDocumentParams: Encodable {
	let accept, document_uid: String
	var ip_address: String? = nil
	var user_name: String? = nil
	var customer_uid: String? = nil /// Required for AcknowledgeDocument but omitted for BatchAcknowledgeDocuments
}

/// ComplianceWorkflowBatchDocumentsParams are the body params used when acknowledging multiple compliance documents
public struct ComplianceWorkflowBatchDocumentsParams: Encodable {
	let customer_uid: String
	let documents: [ComplianceWorkflowDocumentParams]
}

// swiftlint:enable identifier_name redundant_optional_initialization
