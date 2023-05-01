//
// Transactions API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Transactions {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Transactions filtered by the given parameters
	/// - Parameter query: TransactionListParams
	/// - Returns: TransactionList
	internal func list(query: TransactionListParams) async throws -> TransactionList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "transactions", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(TransactionList.self, from: data)
	}

	/// Get returns a single Transaction
	/// - Parameter uid: Transaction UID
	/// - Returns: Transaction
	internal func get(uid: String) async throws -> Transaction? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "transactions/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Transaction.self, from: data)
	}

	/// ListTransactionEvents retrieves a list of Transaction Events filtered by the given parameters
	/// - Parameter query: TransactionEventListParams
	/// - Returns: TransactionEventList
	internal func listTransactionEvents(query: TransactionEventListParams) async throws -> TransactionEventList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "transaction_events", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(TransactionEventList.self, from: data)
	}

	/// GetTransactionEvent returns a single Transaction Event
	/// - Parameter uid: Transaction Event UID
	/// - Returns: TransactionEvent
	internal func getTransactionEvent(uid: String) async throws -> TransactionEvent? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "transaction_events/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(TransactionEvent.self, from: data)
	}

	/// ListSyntheticLineItems retrieves a list of Synthetic Line Items filtered by the given parameters
	/// - Parameter query: SyntheticLineItemListParams
	/// - Returns: SyntheticLineItemList
	internal func listSyntheticLineItems(query: SyntheticLineItemListParams) async throws -> SyntheticLineItemList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "synthetic_line_items", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticLineItemList.self, from: data)
	}

	/// GetSyntheticLineItem returns a single Synthetic Line Item
	/// - Parameter uid: Synthetic Line Item UID
	/// - Returns: SyntheticLineItem
	internal func getSyntheticLineItem(uid: String) async throws -> SyntheticLineItem? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "synthetic_line_items/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SyntheticLineItem.self, from: data)
	}

	/// ListCustodialLineItems retrieves a list of Custodial Line Items filtered by the given parameters
	/// - Parameter query: CustodialLineItemListParams
	/// - Returns: CustodialLineItemList
	internal func listCustodialLineItems(query: CustodialLineItemListParams) async throws -> CustodialLineItemList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "custodial_line_items", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustodialLineItemList.self, from: data)
	}

	/// GetCustodialLineItem returns a single Custodial Line Item
	/// - Parameter uid: Custodial Line Item UID
	/// - Returns: CustodialLineItem
	internal func getCustodialLineItem(uid: String) async throws -> CustodialLineItem? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "custodial_line_items/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustodialLineItem.self, from: data)
	}
}
