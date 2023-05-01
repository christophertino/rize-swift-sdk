//
// Pool Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

/// PoolList is an API response containing a list of Pools
public struct PoolList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Pool]?
}

/// Pool data type
public struct Pool: Decodable {
	let uid,
		name,
		owner_customer_uid: String?
	let customer_uids: [String]?
}

/// PoolListParams builds the query parameters used in querying Pools
public struct PoolListParams: Encodable {
	var customer_uid: String? = nil
	var external_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
