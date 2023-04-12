//
// Auth API
// 
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import SwiftJWT
import Foundation

private struct JWTClaims: Claims {
	let iat: Date
	let sub: String
}

public struct Auth {
	internal let config: RizeConfig?

	public init(config: RizeConfig?) {
		self.config = config
	}

	/// GetToken generates an authorization token if the existing token is expired or not found.
	/// Otherwise, it will return the existing active token,
	public func getToken() {
		let refreshToken = buildRefreshToken()
		Utils.logger(refreshToken)
	}

	/// Generates a JWT refresh token
	private func buildRefreshToken() -> String? {
		let claims = JWTClaims(iat: Date(timeIntervalSince1970: TimeInterval(Int(Date().timeIntervalSince1970))), sub: (self.config?.programUID)!)
		let jwtSigner = JWTSigner.hs512(key: (config?.hmacKey?.data(using: .utf8))!)
		var jwt = JWT(claims: claims)
		let signedJWT = try? jwt.sign(using: jwtSigner)

		return signedJWT
	}
}
