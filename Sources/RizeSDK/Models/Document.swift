//
// Document Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// DocumentList is an API response containing a list of Documents
public struct DocumentList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Document]?
}

/// Document data type
public struct Document: Decodable {
	let uid,
		document_type,
		scope_type,
		name: String?
	let period_started_at,
		period_ended_at,
		created_at: Date?
	let customer_uids,
		custodial_account_uids,
		synthetic_account_uids: [String]?
}

/// DocumentListParams builds the query parameters used in querying Documents
public struct DocumentListParams: Encodable {
	var document_type: String? = nil
	var month: Int? = nil
	var year: Int? = nil
	var custodial_account_uid: String? = nil
	var customer_uid: String? = nil
	var synthetic_account_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
