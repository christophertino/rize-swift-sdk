//
// Pinwheel Jobs API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct PinwheelJobs {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Pinwheel Jobs filtered by the given parameters
	/// - Parameter query: PinwheelJobListParams
	/// - Returns: PinwheelJobList
	internal func list(query: PinwheelJobListParams) async throws -> PinwheelJobList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "pinwheel_jobs", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(PinwheelJobList.self, from: data)
	}

	/// Create is used to initialize a new Pinwheel Job and return a pinwheel_link_token to be used with the Pinwheel Link SDK
	/// - Parameter body: PinwheelJobCreateParams
	/// - Throws: HTTPServiceError
	/// - Returns: PinwheelJob
	internal func create(body: PinwheelJobCreateParams) async throws -> PinwheelJob? {
		if body.job_names.isEmpty || body.synthetic_account_uid.isEmpty {
			throw HTTPServiceError.invalidBodyParameters(description: "job_names and synthetic_account_uid are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "pinwheel_jobs", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(PinwheelJob.self, from: data)
	}

	/// Get returns a single PinwheelJob
	/// - Parameter uid: Job UID
	/// - Throws: HTTPServiceError
	/// - Returns: PinwheelJob
	internal func get(uid: String) async throws -> PinwheelJob? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "pinwheel_jobs/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(PinwheelJob.self, from: data)
	}
}
