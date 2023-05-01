//
// Custodial Partner Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

/// CustodialPartnerList is an API response containing a list of Custodial Partners
public struct CustodialPartnerList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [CustodialPartner]?
}

/// CustodialPartner data type
public struct CustodialPartner: Decodable {
	let uid, name, type: String?
}

// swiftlint:enable identifier_name redundant_optional_initialization
