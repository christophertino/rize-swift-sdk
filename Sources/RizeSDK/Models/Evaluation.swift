//
// Evaluation Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// EvaluationList is an API response containing a list of Evaluations
public struct EvaluationList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Evaluation]?
}

/// Evaluation data type
public struct Evaluation: Decodable {
	let uid, outcome: String?
	let created_at: Date?
	let flags: EvaluationFlag?
	let pii_match: EvaluationPIIMatch?
}

/// EvaluationFlag provides a mapping of categories to outcomes for those categories
public struct EvaluationFlag: Decodable {
	let documentQualityCheck, fraudCheck, financialCheck, watchListCheck: Bool?
	enum CodingKeys: String, CodingKey {
		case documentQualityCheck = "Document Quality Check"
		case fraudCheck = "Fraud Check"
		case financialCheck = "Financial Check"
		case watchListCheck = "Watch List Check"
	}
}

/// EvaluationPIIMatch provides a mapping of KYC categories to results returned from various services
public struct EvaluationPIIMatch: Decodable {
	let dobMatch,
		ssnMatch,
		nameMatch,
		emailMatch,
		phoneMatch,
		addressMatch: Bool?
	enum CodingKeys: String, CodingKey {
		case dobMatch = "DOB Match"
		case ssnMatch = "SSN Match"
		case nameMatch = "Name Match"
		case emailMatch = "Email Match"
		case phoneMatch = "Phone Match"
		case addressMatch = "Address Match"
	}
}

/// EvaluationListParams builds the query parameters used in querying Evaluations
public struct EvaluationListParams: Encodable {
	var customer_uid: String? = nil
	var latest: Bool? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
