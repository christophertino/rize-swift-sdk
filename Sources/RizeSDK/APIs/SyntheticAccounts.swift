//
// Synthetic Accounts API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct SyntheticAccounts {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Synthetic Account filtered by the given parameters
	/// - Parameter query: SyntheticAccountListParams
	/// - Returns: SyntheticAccountList
	internal func list(query: SyntheticAccountListParams) async throws -> SyntheticAccountList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "synthetic_accounts", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticAccountList.self, from: data)
	}

	/// Create a new Synthetic Account in the Pool with the provided specification
	/// - Parameter body: SyntheticAccountCreateParams
	/// - Returns: SyntheticAccount
	internal func create(body: SyntheticAccountCreateParams) async throws -> SyntheticAccount? {
		if body.name.isEmpty || body.pool_uid.isEmpty || body.synthetic_account_type_uid.isEmpty {
			throw HTTPServiceError.invalidBodyParameters(description: "name, pool_uid and synthetic_account_type_uid are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "synthetic_accounts", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticAccount.self, from: data)
	}

	/// Get returns a single Synthetic Account resource along with supporting details and account balances
	/// - Parameter uid: Synthetic Account UID
	/// - Returns: SyntheticAccount
	internal func get(uid: String) async throws -> SyntheticAccount? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "synthetic_accounts/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticAccount.self, from: data)
	}

	/// Update the Synthetic Account metadata
	/// - Parameters:
	///   - uid: Synthetic Account UID
	///   - body: SyntheticAccountUpdateParams
	/// - Returns: SyntheticAccount
	internal func update(uid: String, body: SyntheticAccountUpdateParams) async throws -> SyntheticAccount? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "PUT", path: "synthetic_accounts/\(uid)", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticAccount.self, from: data)
	}

	/// Delete will archive a Synthetic Account
	/// - Parameter uid: Synthetic Account UID
	/// - Returns: HTTPURLResponse
	internal func delete(uid: String) async throws -> HTTPURLResponse? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (response, _) = try await HTTPService().doRequest(method: "DELETE", path: "synthetic_accounts/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return response
	}

	/// ListAccountTypes retrieves a list of Synthetic Account Types filtered by the given parameters
	/// - Parameter query: SyntheticAccountTypeListParams
	/// - Returns: SyntheticAccountTypeList
	internal func listAccountTypes(query: SyntheticAccountTypeListParams) async throws -> SyntheticAccountTypeList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "synthetic_account_types", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticAccountTypeList.self, from: data)
	}

	/// GetAccountType returns a single Synthetic Account Type resource along with supporting details
	/// - Parameter uid: Synthetic Account Type UID
	/// - Returns: SyntheticAccountType
	internal func getAccountType(uid: String) async throws -> SyntheticAccountType? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "synthetic_account_types/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticAccountType.self, from: data)
	}
}
