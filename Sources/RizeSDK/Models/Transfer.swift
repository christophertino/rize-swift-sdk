//
// Transfer Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// TransferList is an API response containing a list of Transfers
public struct TransferList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Transfer]?
}

/// Transfer data type
public struct Transfer: Decodable {
	let uid,
		external_uid,
		source_synthetic_account_uid,
		destination_synthetic_account_uid,
		initiating_customer_uid,
		status,
		usd_transfer_amount,
		usd_requested_amount: String?
	let created_at: Date?
}

/// TransferListParams builds the query parameters used in querying Transfers
public struct TransferListParams: Encodable {
	var customer_uid: String? = nil
	var external_uid: String? = nil
	var pool_uid: String? = nil
	var synthetic_account_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

/// TransferCreateParams are the body params used when creating a new Transfer
public struct TransferCreateParams: Encodable {
	var external_uid: String? = nil
	let source_synthetic_account_uid,
		destination_synthetic_account_uid,
		initiating_customer_uid,
		usd_transfer_amount: String
}

// swiftlint:enable identifier_name redundant_optional_initialization
