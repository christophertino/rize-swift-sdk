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
public struct Customer: Codable {
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
public struct CustomerDetails: Codable {
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
public struct CustomerAddress: Codable {
	let street1,
		street2,
		city,
		state,
		postal_code: String?
}

/// CustomerProfileResponse contains Profile Response info
public struct CustomerProfileResponse: Codable {
	let profile_requirement,
		profile_requirement_uid,
		profile_response: String?
}

public struct CustomerListParams: Encodable {
	let uid,
		status,
		kyc_status,
		customer_type,
		first_name,
		last_name,
		email,
		program_uid,
		business_name,
		external_uid,
		pool_uid,
		sort: String?
	let locked, include_initiated: Bool?
	let limit, offset: Int?
}
