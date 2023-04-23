//
// Customers API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Customers {
	/// List retrieves a list of Customers filtered by the given parameters
	internal func list(query: CustomerListParams) async throws -> CustomerList? {
		let params = query.encodeURLQueryItem
		let data = try await HTTPService().doRequest(method: "GET", path: "customers", query: params, body: nil)
		let response = try? JSONDecoder().decode(CustomerList.self, from: data)
		return response
	}
}
