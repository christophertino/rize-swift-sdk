//
// Customer
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

/// Default 'List' endpoint response.
public struct CustomerList: Decodable {
	let total_count, count, limit, offset: Int
	let data: [Customer?]
}

/// Customer data type
public struct Customer: Decodable {
	let uid,
		external_uid,
		activated_at,
		created_at,
		customer_type,
		email,
		kyc_status,
		lock_reason,
		locked_at,
		pii_confirmed_at,
		primary_customer_uid,
		program_uid,
		status,
		total_balance: String?
	let poolUids, kyc_status_reasons, secondary_customer_uids: [String?]
	let details: CustomerDetails?
	let profile_responses: [CustomerProfileResponse?]
}

/// CustomerDetails is an object containing the supplied identifying information for the Customer
public struct CustomerDetails: Decodable {
	let first_name,
		middle_name,
		last_name,
		suffix,
		phone,
		business_name,
		dob,
		ssn,
		ssn_last_four,
		address: String?
}

/// CustomerAddress information
public struct CustomerAddress: Decodable {
	let street1,
		street2,
		city,
		state,
		postal_code: String?
}

/// CustomerProfileResponse contains Profile Response info
public struct CustomerProfileResponse: Decodable {
	let profile_requirement,
		profile_requirement_uid,
		profile_response: String?
}

/// CustomerListParams builds the query parameters used in querying Customers
public struct CustomerListParams: Encodable {
	var uid: String? = nil
	var status: String? = nil
	var kyc_status: String? = nil
	var customer_type: String? = nil
	var first_name: String? = nil
	var last_name: String? = nil
	var email: String? = nil
	var program_uid: String? = nil
	var business_name: String? = nil
	var external_uid: String? = nil
	var pool_uid: String? = nil
	var sort: String? = nil
	var locked: Bool? = nil
	var include_initiated: Bool? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}
