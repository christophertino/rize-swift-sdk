//
// Sandboxes API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Sandboxes {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// Create a Transaction by simulating the attributes that would be expected from reading an actual transaction received from a third party system
	/// - Parameter body: SandboxCreateParams
	/// - Returns: SandboxResponse
	internal func create(body: SandboxCreateParams) async throws -> SandboxResponse? {
		if body.transaction_type.isEmpty ||
			body.customer_uid.isEmpty ||
			body.debit_card_uid.isEmpty ||
			body.us_dollar_amount.isZero {
			throw HTTPServiceError.invalidBodyParameters(description: "transaction_type, customer_uid, debit_card_uid and us_dollar_amount are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "sandbox/mock_transactions", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(SandboxResponse.self, from: data)
	}

}
