//
// AuthToken
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

/// AuthToken is the response format received when fetching an Auth token
public struct AuthToken: Decodable {
	let token: String
}
