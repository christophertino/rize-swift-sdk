//
// Custodial Partners API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct CustodialPartners {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Custodial Partners
	/// - Returns: CustodialPartnerList
	internal func list() async throws -> CustodialPartnerList? {
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "custodial_partners", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustodialPartnerList.self, from: data)
	}

	/// Get returns a single Custodial Partner
	/// - Parameter uid: Custodial Partner UID
	/// - Returns: CustodialPartner
	internal func get(uid: String) async throws -> CustodialPartner? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "custodial_partners/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(CustodialPartner.self, from: data)
	}
}
