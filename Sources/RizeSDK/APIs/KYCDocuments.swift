//
// KYC Documents API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct KYCDocuments {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// List retrieves a list of KYC Documents for a given evaluation
	/// - Parameter query: KYCDocumentListParams
	/// - Returns: KYCDocumentList
	internal func list(query: KYCDocumentListParams) async throws -> KYCDocumentList? {
		if query.evaluation_uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "evaluation_uid is required")
		}

		let params = query.encodeURLQueryItem
		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "kyc_documents", query: params, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(KYCDocumentList.self, from: data)
	}

	/// Upload a KYC Document for review
	/// - Parameter body: KYCDocumentUploadParams
	/// - Returns: KYCDocument
	internal func upload(body: KYCDocumentUploadParams) async throws -> KYCDocument? {
		if body.evaluation_uid.isEmpty ||
			body.filename.isEmpty ||
			body.file_content.isEmpty ||
			body.note.isEmpty ||
			body.type.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "all KYCDocumentUploadParams are required")
		}

		let params = try JSONEncoder().encode(body)
		guard let (_, data) = try await HTTPService().doRequest(method: "POST", path: "kyc_documents", query: nil, body: params) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(KYCDocument.self, from: data)
	}

	/// Get is used to retrieve metadata for a KYC Document previously uploaded
	/// - Parameter uid: Document UID
	/// - Returns: KYCDocument
	internal func get(uid: String) async throws -> KYCDocument? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (_, data) = try await HTTPService().doRequest(method: "GET", path: "kyc_documents/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return try self.decoder.decode(KYCDocument.self, from: data)
	}

	/// View is used to retrieve a KYC Document (image, PDF, etc) previously uploaded
	/// - Parameter uid: Document UID
	/// - Returns: HTTPURLResponse
	internal func view(uid: String) async throws -> HTTPURLResponse? {
		if uid.isEmpty {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		guard let (response, _) = try await HTTPService().doRequest(method: "GET", path: "kyc_documents/\(uid)", query: nil, body: nil) as? (HTTPURLResponse, Data) else {
			return nil
		}
		return response
	}
}
