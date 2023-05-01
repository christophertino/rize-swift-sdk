//
// Pinwheel Job Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// PinwheelJobList is an API response containing a list of Pinwheel Jobs
public struct PinwheelJobList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [PinwheelJob]?
}

/// PinwheelJob data type
public struct PinwheelJob: Decodable {
	let uid,
		synthetic_account_uid,
		status,
		customer_uid,
		link_token,
		organization_name: String?
	let created_at,
		status_updated_at,
		expires_at: Date?
	let job_names: [String]?
	let amount: Int?
	let disable_partial_switch, skip_welcome_screen: Bool?
}

/// PinwheelJobListParams builds the query parameters used in querying Pinwheel Jobs
public struct PinwheelJobListParams: Encodable {
	var customer_uid: String? = nil
	var synthetic_account_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

/// PinwheelJobCreateParams are the body params used when creating a new Pinwheel Job
public struct PinwheelJobCreateParams: Encodable {
	let job_names: [String]
	let synthetic_account_uid: String
	var amount: Int? = nil
	var disable_partial_switch: Bool? = nil
	var organization_name: String? = nil
	var skip_welcome_screen: Bool? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
