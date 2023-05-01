//
// Card Artwork Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// Default 'List' endpoint response.
public struct CardArtworkList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [CardArtwork]?
}

/// CardArtwork data type
public struct CardArtwork: Decodable {
	let uid,
		name,
		program_uid,
		style_id: String?
	let is_default, staged: Bool?
}

/// CardArtworkListParams builds the query parameters used in querying Card Artwork
public struct CardArtworkListParams: Encodable {
	var program_uid: String? = nil
	var limit: Int? = nil
	var offset: Int? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
