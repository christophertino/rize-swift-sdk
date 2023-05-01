//
// Adjustments API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Adjustments {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Adjustments filtered by the given parameters
	/// - Parameter query: AdjustmentListParams
	/// - Returns: AdjustmentList
	internal func list(query: AdjustmentListParams) async throws -> AdjustmentList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "adjustments", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(AdjustmentList.self, from: data)
	}

	/// Create a new Adjustment with the provided specification
	/// - Parameter body: AdjustmentCreateParams
	/// - Returns: Adjustment
	internal func create(body: AdjustmentCreateParams) async throws -> Adjustment? {
		if body.customer_uid.isEmpty ||
			body.usd_adjustment_amount.isEmpty ||
			body.adjustment_type_uid.isEmpty {
			throw HTTPServiceError.invalidBodyParameters(description: "customer_uid, usd_adjustment_amount and adjustment_type_uid are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "adjustments", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Adjustment.self, from: data)
	}

	/// Get returns a single Adjustment
	/// - Parameter uid: Adjustment UID
	/// - Returns: Adjustment
	internal func get(uid: String) async throws -> Adjustment? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "adjustments/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Adjustment.self, from: data)
	}

	/// ListAdjustmentTypes retrieves a list of Adjustment Types filtered by the given parameters
	/// - Parameter query: AdjustmentTypeListParams
	/// - Returns: AdjustmentTypeList
	internal func listAdjustmentTypes(query: AdjustmentTypeListParams) async throws -> AdjustmentTypeList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "adjustment_types", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(AdjustmentTypeList.self, from: data)
	}

	/// GetAdjustmentType returns a single Adjustment Type
	/// - Parameter uid: AdjustmentType UID
	/// - Returns: AdjustmentType
	internal func getAdjustmentType(uid: String) async throws -> AdjustmentType? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "adjustment_types/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(AdjustmentType.self, from: data)
	}
}
