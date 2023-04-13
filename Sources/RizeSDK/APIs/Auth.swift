//
// Auth API
// 
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import SwiftJWT
import Foundation

/// JWTClaims for generating a JWT token
private struct JWTClaims: Claims {
	let iat: Date
	let sub: String
}

/// AuthTokenResponse is the response format received when fetching an Auth token
private struct AuthTokenResponse: Decodable {
	let Token: String
}

public struct Auth {
	/// GetToken generates an authorization token if the existing token is expired or not found.
	/// Otherwise, it will return the existing active token,
	public func getToken() {
		let refreshToken: String?
		do {
			refreshToken = try buildRefreshToken()
		} catch {
			Utils.logger("Error building refresh token: \(error.localizedDescription)")
			return
		}

		HTTPService.doRequest(method: <#T##String#>, path: <#T##String#>, query: <#T##String?#>, body: <#T##Data?#>, completion: <#T##(Result<Decodable, Error>) -> Void#>)

		Utils.logger(refreshToken)
		
	}

	/// Generates a JWT refresh token
	/// - Returns: Signed JWT
	private func buildRefreshToken() throws -> String? {
		let epochTime = Date(timeIntervalSince1970: TimeInterval(Int(Date().timeIntervalSince1970)))
		let claims = JWTClaims(iat: epochTime, sub: (RizeSDK.config?.programUID)!)
		let jwtSigner = JWTSigner.hs512(key: (RizeSDK.config?.hmacKey?.data(using: .utf8))!)
		var jwt = JWT(claims: claims)
		guard let signedJWT = try? jwt.sign(using: jwtSigner) else {
			throw JWTError.invalidJWTString
		}

		return signedJWT
	}
}
