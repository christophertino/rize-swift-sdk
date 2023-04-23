//
// Customer
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// Default 'List' endpoint response.
public struct CustomerList: Decodable {
	let total_count, count, limit, offset: Int
	let data: [Customer?]
}

/// Customer data type
public struct Customer: Decodable {
	let uid,
		external_uid,
		customer_type,
		email,
		kyc_status,
		lock_reason,
		primary_customer_uid,
		program_uid,
		status,
		total_balance: String?
	let activated_at,
		created_at,
		locked_at,
		pii_confirmed_at: Date?
	let poolUids, kyc_status_reasons, secondary_customer_uids: [String]?
	let details: CustomerDetails?
	let profile_responses: [CustomerProfileResponse]?
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

/// CustomerCreateParams are the body params used when creating a new Customer
public struct CustomerCreateParams: Encodable {
	var customer_type: String? = nil
	var primary_customer_uid: String? = nil
	var external_uid: String? = nil
	var email: String? = nil
	var details: CustomerDetails? = nil
}

/// CustomerUpdateParams are the body params used when updating a Customer
public struct CustomerUpdateParams: Encodable {
	var email: String? = nil
	var details: CustomerDetails? = nil
	var external_uid: String? = nil
}

/// CustomerDeleteParams are the body params used when deleting/archiving a Customer
public struct CustomerDeleteParams: Encodable {
	var archive_note: String? = nil
}

/// CustomerLockParams are the body params used when locking/unlocking a Customer
public struct CustomerLockParams: Encodable {
	var lock_note: String? = nil
	var lock_reason: String? = nil
	var unlock_reason: String? = nil
}

/// CustomerProfileResponseParams are the body params used when updating Customer Profile responses
public struct CustomerProfileResponseParams: Encodable {
	var profile_requirement_uid: String? = nil
	var profile_response: String? = nil
}
