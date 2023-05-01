//
// Customer Product Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

/// CustomerProductList is an API response containing a list of Customer Products
public struct CustomerProductList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [CustomerProduct]?
}

/// CustomerProduct data type
public struct CustomerProduct: Decodable {
	let uid,
		status,
		customer_uid,
		customer_email,
		product_uid,
		product_name,
		program_uid: String?
}

/// CustomerProductListParams builds the query parameters used in querying Customer Products
public struct CustomerProductListParams: Encodable {
	var program_uid: String? = nil
	var product_uid: String? = nil
	var customer_uid: String? = nil
}

/// CustomerProductCreateParams are the body params used when creating a new Customer Product
public struct CustomerProductCreateParams: Encodable {
	let customer_uid, product_uid: String
}

// swiftlint:enable identifier_name redundant_optional_initialization
