//
// Transaction Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// TransactionList is an API response containing a list of Transactions
public struct TransactionList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Transaction]?
}

/// Transaction data type
public struct Transaction: Decodable {
	let adjustment_uid,
		customer_uid,
		debit_card_uid,
		denial_reason,
		description,
		destination_synthetic_account_uid,
		mcc,
		merchant_location,
		merchant_name,
		merchant_number,
		net_asset,
		source_synthetic_account_uid,
		status,
		transfer_uid,
		type,
		uid,
		us_dollar_amount: String?
	let id, settled_index: Int?
	let created_at, initial_action_at, settled_at: Date?
	let custodial_account_uids, transaction_event_uids: [String]?
}

/// TransactionListParams builds the query parameters used in querying Transactions
public struct TransactionListParams: Encodable {
	var customer_uid: String? = nil
	var pool_uid: String? = nil
	var debit_card_uid: String? = nil
	var source_synthetic_account_uid: String? = nil
	var destination_synthetic_account_uid: String? = nil
	var type: String? = nil
	var synthetic_account_uid: String? = nil
	var show_denied_auths: Bool? = nil
	var show_expired: Bool? = nil
	var status: String? = nil
	var search_description: String? = nil
	var include_zero: Bool? = nil
	var limit: Int? = nil
	var offset: Int? = nil
	var sort: String? = nil
}

/// TransactionEventList is an API response containing a list of TransactionEvents
public struct TransactionEventList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [TransactionEvent]?
}

/// TransactionEvent data type
public struct TransactionEvent: Decodable {
	let uid,
		source_custodial_account_uid,
		destination_custodial_account_uid,
		status,
		us_dollar_amount,
		type,
		debit_card_uid,
		net_asset,
		description: String?
	let settled_index: Int?
	let transaction_uids, custodial_line_item_uids: [String]?
	let created_at, settled_at: Date?
}

/// TransactionEventListParams builds the query parameters used in querying TransactionEvents
public struct TransactionEventListParams: Encodable {
	var source_custodial_account_uid: String? = nil
	var destination_custodial_account_uid: String? = nil
	var custodial_account_uid: String? = nil
	var type: String? = nil
	var transaction_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
	var sort: String? = nil
}

/// SyntheticLineItemList is an API response containing a list of SyntheticLineItems
public struct SyntheticLineItemList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [SyntheticLineItem]?
}

/// SyntheticLineItem data type
public struct SyntheticLineItem: Decodable {
	let uid,
		transaction_uid,
		synthetic_account_uid,
		status,
		us_dollar_amount,
		running_us_dollar_balance,
		running_asset_balance,
		asset_quantity,
		asset_type,
		closing_price,
		custodial_account_uid,
		custodial_account_name,
		description: String?
	let settled_index: Int?
	let created_at, settled_at: Date?
}

/// SyntheticLineItemListParams builds the query parameters used in querying SyntheticLineItems
public struct SyntheticLineItemListParams: Encodable {
	var customer_uid: String? = nil
	var pool_uid: String? = nil
	var synthetic_account_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
	var transaction_uid: String? = nil
	var status: String? = nil
	var sort: String? = nil
}

/// CustodialLineItemList is an API response containing a list of CustodialLineItems
public struct CustodialLineItemList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [CustodialLineItem]?
}

/// CustodialLineItem data type
public struct CustodialLineItem: Decodable {
	let uid,
		transaction_uid,
		transaction_event_uid,
		custodial_account_uid,
		debit_card_uid,
		status,
		us_dollar_amount,
		running_us_dollar_balance,
		running_asset_balance,
		asset_quantity,
		asset_type,
		closing_price,
		type,
		description: String?
	let settled_index: Int?
	let created_at, occurred_at, settled_at: Date?
}

/// CustodialLineItemListParams builds the query parameters used in querying CustodialLineItems
public struct CustodialLineItemListParams: Encodable {
	var customer_uid: String? = nil
	var custodial_account_uid: String? = nil
	var status: String? = nil
	var us_dollar_amount_max: Int? = nil
	var us_dollar_amount_min: Int? = nil
	var transaction_event_uid: String? = nil
	var transaction_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
	var sort: String? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
