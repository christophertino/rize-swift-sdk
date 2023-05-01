//
// Debit Cards API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct DebitCards {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Debit Cards filtered by the given parameters
	/// - Parameter query: DebitCardListParams
	/// - Returns: DebitCardList
	internal func list(query: DebitCardListParams) async throws -> DebitCardList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "debit_cards", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCardList.self, from: data)
	}

	/// Create is used to a new Debit Card and attach it to the supplied Customer and Pool
	/// - Parameter body: DebitCardCreateParams
	/// - Returns: DebitCard
	internal func create(body: DebitCardCreateParams) async throws -> DebitCard? {
		if body.customer_uid == "" || body.pool_uid == "" {
			throw HTTPServiceError.invalidBodyParameters(description: "customer_uid and pool_uid are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "debit_cards", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCard.self, from: data)
	}

	/// Get returns a single DebitCard
	/// - Parameter uid: Debit Card UID
	/// - Returns: DebitCard
	internal func get(uid: String) async throws -> DebitCard? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "debit_cards/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCard.self, from: data)
	}

	/// Activate a Debit Card
	/// - Parameters:
	///   - uid: Debit Card UID
	///   - body: DebitCardActivateParams
	/// - Returns: DebitCard
	internal func activate(uid: String, body: DebitCardActivateParams) async throws -> DebitCard? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		if body.card_last_four_digits.isEmpty || body.cvv.isEmpty || body.expiry_date.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "card_last_four_digits, cvv and expiry_date are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "debit_cards/\(uid)/activate", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCard.self, from: data)
	}

	/// Lock will temporarily lock the Debit Card
	/// - Parameters:
	///   - uid: Debit Card UID
	///   - body: DebitCardLockParams
	/// - Returns: DebitCard
	internal func lock(uid: String, body: DebitCardLockParams) async throws -> DebitCard? {
		if uid.isEmpty || body.lock_reason.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID and lock_reason are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "debit_cards/\(uid)/lock", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCard.self, from: data)
	}

	/// Unlock will attempt to remove a lock placed on a Debit Card
	/// - Parameter uid: Debit Card UID
	/// - Returns: DebitCard
	internal func unlock(uid: String) async throws -> DebitCard? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "debit_cards/\(uid)/unlock", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCard.self, from: data)
	}

	/// Reissue a Debit Card that is lost or stolen, or when it has suffered damage
	/// - Parameters:
	///   - uid: Debit Card UID
	///   - body: DebitCardReissueParams
	/// - Returns: DebitCard
	internal func reissue(uid: String, body: DebitCardReissueParams) async throws -> DebitCard? {
		if uid.isEmpty || body.reissue_reason.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID and reissue_reason are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "debit_cards/\(uid)/reissue", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCard.self, from: data)
	}

	/// GetPINToken is used to retrieve a token necessary to change a Debit Card's PIN
	/// - Parameters:
	///   - uid: Debit Card UID
	///   - body: DebitCardGetPINTokenParams
	/// - Returns: DebitCardPINTokenResponse
	internal func getPINToken(uid: String, body: DebitCardGetPINTokenParams) async throws -> DebitCardPINTokenResponse? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "debit_cards/\(uid)/pin_change_token", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCardPINTokenResponse.self, from: data)
	}

	/// GetAccessToken is used to retrieve the configuration ID and token necessary to retrieve a virtual Debit Card image
	/// - Parameter uid: Debit Card UID
	/// - Returns: DebitCardAccessToken
	internal func getAccessToken(uid: String) async throws -> DebitCardAccessToken? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "debit_cards/\(uid)/access_token", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCardAccessToken.self, from: data)
	}

	/// MigrateVirtualDebitCard will result in a physical version of the virtual debit card being issued to a Customer
	/// - Parameters:
	///   - uid: Virtual Debit Card UID
	///   - body: VirtualDebitCardMigrateParams
	/// - Returns: DebitCard
	internal func migrateVirtualDebitCard(uid: String, body: VirtualDebitCardMigrateParams) async throws -> DebitCard? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "debit_cards/\(uid)/migrate", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DebitCard.self, from: data)
	}

	/// GetVirtualDebitCardImage is used to retrieve a virtual Debit Card image
	/// - Parameter query: VirtualDebitCardQueryParams
	/// - Returns: HTTPURLResponse
	internal func getVirtualDebitCardImage(query: VirtualDebitCardQueryParams) async throws -> HTTPURLResponse? {
		if query.config.isEmpty || query.token.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "config and token are required")
		}

		let params = query.encodeURLQueryItem
		guard let (response, _) = try await HTTPService().doRequest(method: "GET", path: "assets/virtual_card_image", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return response
	}
}
