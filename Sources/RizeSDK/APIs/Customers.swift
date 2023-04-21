//
// Customers API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

public struct Customers {
	public func list(params: CustomerListParams) async throws -> CustomerList? {
		let data = try await HTTPService().doRequest(method: "GET", path: "customers", query: nil, body: nil)
		let response = try? JSONDecoder().decode(CustomerList.self, from: data)

		return response
	}
}
