//
// Transfers API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Transfers {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Transfers filtered by the given parameters
	/// - Parameter query: TransferListParams
	/// - Returns: TransferList
	internal func list(query: TransferListParams) async throws -> TransferList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "transfers", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(TransferList.self, from: data)
	}

	/// Create will initiate a Transfer between two Synthetic Accounts
	/// - Parameter body: TransferCreateParams
	/// - Returns: Transfer
	internal func create(body: TransferCreateParams) async throws -> Transfer? {
		if body.source_synthetic_account_uid.isEmpty ||
			body.destination_synthetic_account_uid.isEmpty ||
			body.initiating_customer_uid.isEmpty ||
			body.usd_transfer_amount.isEmpty {
			throw HTTPServiceError.invalidBodyParameters(description: "source_synthetic_account_uid, destination_synthetic_account_uid, initiating_customer_uid and usd_transfer_amount are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "transfers", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Transfer.self, from: data)
	}

	/// Get returns a single Transfer
	/// - Parameter uid: Transfer UID
	/// - Returns: Transfer
	internal func get(uid: String) async throws -> Transfer? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "transfers/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Transfer.self, from: data)
	}
}
