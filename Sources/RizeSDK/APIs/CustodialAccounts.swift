//
// Custodial Accounts API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct CustodialAccounts {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Custodial Accounts filtered by the given parameters
	/// - Parameter query: CustodialAccountListParams
	/// - Returns: CustodialAccountList
	internal func list(query: CustodialAccountListParams) async throws -> CustodialAccountList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "custodial_accounts", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustodialAccountList.self, from: data)
	}

	/// Get returns a single Custodial Account
	/// - Parameter uid: Custodial Account UID
	/// - Returns: CustodialAccount
	internal func get(uid: String) async throws -> CustodialAccount? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "custodial_accounts/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustodialAccount.self, from: data)
	}
}
