//
// Adjustment Model
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//
// swiftlint:disable identifier_name redundant_optional_initialization

import Foundation

/// AdjustmentList is an API response containing a list of Adjustments
public struct AdjustmentList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [Adjustment]?
}

/// AdjustmentTypeList is an API response containing a list of Adjustments Types
public struct  AdjustmentTypeList: Decodable {
	let total_count, count, limit, offset: Int?
	let data: [AdjustmentType]?
}

/// Adjustment data type
public struct Adjustment: Decodable{
	let uid,
		external_uid,
		customer_uid,
		usd_adjustment_amount,
		status: String?
	let adjustment_type: AdjustmentType?
	let created_at: Date?
}

/// AdjustmentType data type
public struct AdjustmentType: Decodable {
	let uid,
		name,
		description,
		program_uid: String?
	let fee, deprecated: Bool?
}

/// AdjustmentListParams builds the query parameters used in querying Adjustments
public struct AdjustmentListParams: Encodable {
	var customer_uid: String? = nil
	var adjustment_type_uid: String? = nil
	var external_uid: String? = nil
	var usd_adjustment_amount_max: Int? = nil
	var usd_adjustment_amount_min: Int? = nil
	var sort: String? = nil
}

/// AdjustmentCreateParams are the body params used when creating a new Adjustment
public struct AdjustmentCreateParams: Encodable {
	var external_uid: String? = nil
	let customer_uid, usd_adjustment_amount, adjustment_type_uid: String
}

/// AdjustmentTypeListParams builds the query parameters used in querying Adjustment Types
public struct AdjustmentTypeListParams: Encodable {
	var customer_uid: String? = nil
	var program_uid: String? = nil
	var show_deprecated: Bool? = nil
}

// swiftlint:enable identifier_name redundant_optional_initialization
