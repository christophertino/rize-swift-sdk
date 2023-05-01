//
// Debit Card Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// DebitCardList is an API response containing a list of Debit Cards
public struct DebitCardList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [DebitCard]?
}

/// DebitCard data type
public struct DebitCard: Decodable {
	let uid,
		external_uid,
		customer_uid,
		pool_uid,
		synthetic_account_uid,
		custodial_account_uid,
		card_artwork_uid,
		card_last_four_digits,
		status,
		type,
		lock_reason,
		issued_on: String?
	let ready_to_use: Bool?
	let locked_at, closed_at: Date?
	let latest_shipping_address: DebitCardShippingAddress?
}

/// DebitCardShippingAddress is an optional field used to specify the shipping address for a physical Debit Card.
public struct DebitCardShippingAddress: Codable {
	let street1,
		street2,
		city,
		state,
		postal_code: String?
}

/// DebitCardAccessToken contains the token necessary to retrieve a virtual Debit Card image.
public struct DebitCardAccessToken: Encodable {
	let token, config_id: String
}

/// DebitCardListParams builds the query parameters used in querying Debit Cards
public struct DebitCardListParams: Encodable {
	var customer_uid: String? = nil
	var external_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
	var pool_uid: String? = nil
	var locked: Bool? = nil
	var status: String? = nil
}

/// DebitCardCreateParams are the body params used when creating a new Debit Card
public struct DebitCardCreateParams: Encodable {
	let customer_uid, pool_uid: String
	var external_uid: String? = nil
	var card_artwork_uid: String? = nil
	var shipping_address: DebitCardShippingAddress? = nil
}

/// DebitCardActivateParams are the body params used when activating a new Debit Card
public struct DebitCardActivateParams: Encodable {
	let card_last_four_digits,
		cvv,
		expiry_date: String
}

/// DebitCardLockParams are the body params used when locking a Debit Card
public struct DebitCardLockParams: Encodable {
	let lock_reason: String
}

/// DebitCardReissueParams are the body params used when reissuing a Debit Card
public struct DebitCardReissueParams: Encodable {
	let reissue_reason: String
	var card_artwork_uid: String? = nil
	var shipping_address: DebitCardShippingAddress? = nil
}

/// DebitCardGetPINTokenParams are the query params used fetching a Debit Card PIN reset token
public struct DebitCardGetPINTokenParams: Encodable {
	let force_reset: Bool
}

/// VirtualDebitCardMigrateParams are the body params used when migrating a Virtual Debit Card
public struct VirtualDebitCardMigrateParams: Encodable {
	var external_uid: String? = nil
	var card_artwork_uid: String? = nil
	var shipping_address: DebitCardShippingAddress? = nil
}

/// VirtualDebitCardQueryParams are the query params used to retrieve a virtual Debit Card image
public struct VirtualDebitCardQueryParams: Encodable {
	let token, config: String
}

/// DebitCardPINTokenResponse is an API response containing a token necessary to change a Debit Card's PIN
public struct DebitCardPINTokenResponse: Decodable {
	let pin_change_token: String
}

// swiftlint:enable identifier_name redundant_optional_initialization
