//
// Product Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

/// ProductList is an API response containing a list of Products
public struct ProductList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Product]?
}

/// Product data type
public struct Product: Decodable {
	let uid,
		name,
		description,
		product_compliance_plan_uid,
		compliance_plan_name,
		program_uid: String?
	let customer_types, prerequisite_product_uids: [String]?
	let profile_requirements: [ProfileRequirement]?
}

/// ProfileRequirement is a list of Profile Requirements a Customer must provide Profile Responses to
public struct ProfileRequirement: Decodable {
	let profile_requirement_uid,
		profile_requirement,
		category,
		requirement_type: String?
	let required: Bool?
	let response_values: [String]?
}

/// ProductListParams builds the query parameters used in querying Products
public struct ProductListParams: Encodable {
	var program_uid: String? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
