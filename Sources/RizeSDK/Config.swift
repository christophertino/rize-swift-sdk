//
// RizeConfig
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

public struct RizeConfig {
	public var programUID: String
	public var hmacKey: String
	public var environment: String
	public var baseURL = "https://sandbox.rizefs.com/"
}
