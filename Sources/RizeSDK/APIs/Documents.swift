//
// Documents API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Documents {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of Documents filtered by the given parameters
	/// - Parameter query: DocumentListParams
	/// - Returns: DocumentList
	internal func list(query: DocumentListParams) async throws -> DocumentList? {
		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "documents", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(DocumentList.self, from: data)
	}

	/// Get returns a single Document
	/// - Parameter uid: Document UID
	/// - Returns: Document
	internal func get(uid: String) async throws -> Document? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "documents/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(Document.self, from: data)
	}

	/// View is used to retrieve a Document and return it in either PDF or HTML format
	/// - Parameter uid: Document UID
	/// - Returns: HTTPURLResponse
	internal func view(uid: String) async throws -> HTTPURLResponse? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (response, _) = try await HTTPService().doRequest(method: "GET", path: "documents/\(uid)/view", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return response
	}
}
