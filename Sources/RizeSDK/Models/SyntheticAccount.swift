//
// Synthetic Account Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// SyntheticAccountList is an API response containing a list of Synthetic Accounts
public struct SyntheticAccountList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [SyntheticAccount]?
}

/// SyntheticAccount data type
public struct SyntheticAccount: Decodable {
	let uid,
		external_uid,
		name,
		pool_uid,
		customer_uid,
		synthetic_account_type_uid,
		synthetic_account_category,
		status,
		net_usd_balance,
		net_usd_pending_balance,
		net_usd_available_balance,
		account_number,
		account_number_last_four,
		routing_number,
		closed_to_synthetic_account_uid: String?
	let liability, master_account: Bool?
	let asset_balances: [SyntheticAccountAssetBalance]?
	let opened_at, closed_at: Date?
}

/// SyntheticAccountAssetBalance provides a list of balances for the various asset types
public struct SyntheticAccountAssetBalance: Decodable {
	let asset_quantity,
		asset_type,
		current_usd_value,
		custodial_account_uid,
		custodial_account_name: String?
	let debit: Bool?
}

/// SyntheticAccountListParams builds the query parameters used in querying Synthetic Accounts
public struct SyntheticAccountListParams: Encodable {
	var customer_uid: String? = nil
	var external_uid: String? = nil
	var pool_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
	var synthetic_account_type_uid: String? = nil
	var synthetic_account_category: String? = nil
	var liability: Bool? = nil
	var status: String? = nil
	var sort: String? = nil
}

/// SyntheticAccountCreateParams are the body params used when creating a new Synthetic Account
public struct SyntheticAccountCreateParams: Encodable {
	let name, pool_uid, synthetic_account_type_uid: String
	var external_uid: String? = nil
	var account_number: String? = nil
	var routing_number: String? = nil
	var plaid_processor_token: String? = nil // Deprecated
	var external_processor_token: String? = nil
}

/// SyntheticAccountUpdateParams are the body params used when updating a Synthetic Account
public struct SyntheticAccountUpdateParams: Encodable {
	var name: String? = nil
	var note: String? = nil
}

/// SyntheticAccountTypeList is an API response containing a list of Synthetic Account Types
public struct SyntheticAccountTypeList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [SyntheticAccountType]?
}

/// SyntheticAccountType data type
public struct SyntheticAccountType: Decodable {
	let uid,
		name,
		description,
		program_uid,
		synthetic_account_category: String?
	let target_annual_yield_percent: Float64?
}

/// SyntheticAccountTypeListParams builds the query parameters used in querying Synthetic Account Types
public struct SyntheticAccountTypeListParams: Encodable {
	var program_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
