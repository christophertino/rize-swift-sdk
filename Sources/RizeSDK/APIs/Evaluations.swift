//
// Evaluations API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Evaluations {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Evaluations filtered by the given parameters
	/// - Parameter query: EvaluationListParams
	/// - Returns: EvaluationList
	internal func list(query: EvaluationListParams) async throws -> EvaluationList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "evaluations", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(EvaluationList.self, from: data)
	}

	/// Get returns a single Evaluation
	/// - Parameter uid: Evaluation UID
	/// - Returns: Evaluation
	internal func get(uid: String) async throws -> Evaluation? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "evaluations/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Evaluation.self, from: data)
	}
}
