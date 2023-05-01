//
// Sandbox Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

/// SandboxResponse is an API response
public struct SandboxResponse: Decodable {
	let success: String
}

/// SandboxCreateParams are the body params used when creating a new Sandbox transaction
public struct SandboxCreateParams: Encodable {
	let transaction_type,
		customer_uid,
		debit_card_uid: String
	let us_dollar_amount: Float64
	var denial_reason: String? = nil
	var mcc: String? = nil
	var merchant_location: String? = nil
	var merchant_name: String? = nil
	var merchant_number: String? = nil
	var description: String? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
