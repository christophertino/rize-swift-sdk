//
// Custodial Account Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// CustodialAccountList is an API response containing a list of Custodial Accounts
public struct CustodialAccountList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [CustodialAccount]?
}

/// CustodialAccount data type
public struct CustodialAccount: Decodable {
	let uid,
		external_uid,
		customer_uid,
		pool_uid,
		type,
		name,
		status,
		net_usd_balance,
		net_usd_pending_balance,
		net_usd_available_balance,
		account_number,
		account_number_masked,
		routing_number: String?
	let liability, primary_account: Bool?
	let account_errors: [CustodialAccountError]?
	let asset_balances: [CustodialAccountAssetBalance]?
	let opened_at, closed_at: Date?
}

/// CustodialAccountError provides errors info related to this account
public struct CustodialAccountError: Decodable {
	let error_code, error_name, error_description: String?
}

/// CustodialAccountAssetBalance provides balance info for the various asset types held in this Custodial Account
public struct CustodialAccountAssetBalance: Decodable {
	let asset_quantity,
		asset_type,
		current_usd_value: String?
	let debit: Bool?
}

/// CustodialAccountListParams builds the query parameters used in querying Custodial Accounts
public struct CustodialAccountListParams: Encodable {
	var customer_uid: String? = nil
	var external_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
	var liability: Bool? = nil
	var type: String? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
