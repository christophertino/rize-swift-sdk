//
// Card Artwork API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct CardArtworks {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Card Artworks, optionally filtering by program
	/// - Parameter query: CardArtworkListParams
	/// - Returns: CardArtworkList
	internal func list(query: CardArtworkListParams) async throws -> CardArtworkList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "card_artworks", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CardArtworkList.self, from: data)
	}

	/// Get returns a single Card Artwork resource
	/// - Parameter uid: Artwork UID
	/// - Returns: CardArtwork
	internal func get(uid: String) async throws -> CardArtwork? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "card_artworks/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CardArtwork.self, from: data)
	}
}
