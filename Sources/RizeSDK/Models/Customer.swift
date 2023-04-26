//
// Customer
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// Default 'List' endpoint response.
public struct CustomerList: Decodable {
	let total_count, count, limit, offset: Int
	let data: [Customer]?
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
	var first_name: String? = nil
	var	middle_name: String? = nil
	var	last_name: String? = nil
	var	suffix: String? = nil
	var	phone: String? = nil
	var	business_name: String? = nil
	var	dob: String? = nil
	var	ssn: String? = nil
	var ssn_last_four: String? = nil
	var address: CustomerAddress? = nil
}

/// CustomerAddress information
public struct CustomerAddress: Codable {
	var street1: String? = nil
	var	street2: String? = nil
	var	city: String? = nil
	var	state: String? = nil
	var	postal_code: String? = nil
}

/// CustomerProfileResponse contains Profile Response info
public struct CustomerProfileResponse: Codable {
	var profile_requirement: String? = nil
	var	profile_requirement_uid: String? = nil
	var	profile_response: String? = nil
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

// swiftlint:enable identifier_name redundant_optional_initialization
