//
// KYC Document Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation

/// KYCDocumentList is an API response containing a list of KYC Documents
public struct KYCDocumentList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [KYCDocument]?
}

/// KYCDocument data type
public struct KYCDocument: Decodable {
	let uid,
		type,
		filename,
		note,
		file_extension: String?
	let created_at: Date?
	enum CodingKeys: String, CodingKey {
		case uid, type, filename, note, created_at
		case file_extension = "extension"
	}
}

/// KYCDocumentListParams builds the query parameters used in querying KYCDocuments
public struct KYCDocumentListParams: Encodable {
	let evaluation_uid: String
}

/// KYCDocumentUploadParams are the body params used when uploading a new KYC Document
public struct KYCDocumentUploadParams: Encodable {
	var evaluation_uid: String
	var filename: String
	var file_content: String
	var note: String
	var type: String
}

// swiftlint:enable identifier_name
