//
// Auth API
// 
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import SwiftJWT
import Foundation

/// AuthTokenResponse is the response format received when fetching an Auth token
public struct AuthTokenResponse: Decodable {
	let token: String
}

// TokenCache stores Auth token data
internal struct TokenCache {
	var token: String?
	var timestamp: Int64?
	static var shared = TokenCache(token: nil, timestamp: nil)
}

/// JWTClaims for generating a JWT token
private struct JWTClaims: Claims {
	let iat: Date
	let sub: String
}

public struct Auth {
	/// GetToken generates an authorization token if the existing token is expired or not found.
	/// Otherwise, it will return the existing active token,
	public func getToken() async throws -> AuthTokenResponse? {
		if TokenCache.shared.token.isEmptyOrNil {
			Utils.logger("Token is expired or does not exist. Fetching new token...")

			let refreshToken = try buildRefreshToken()
			TokenCache.shared.token = refreshToken

			let data = try await HTTPService.doRequest(method: "POST", path: "auth", query: nil, body: nil)
			let response = try? JSONDecoder().decode(AuthTokenResponse.self, from: data)

			// Validate token exists
			if response?.token != nil {
				//  Save token to cache. Auth token is valid for 24hrs
				TokenCache.shared.token = response?.token
				TokenCache.shared.timestamp = Int64(Date().timeIntervalSince1970)
				return response
			}
			return nil
		}
		return AuthTokenResponse(token: TokenCache.shared.token!)
	}

	/// Generates a JWT refresh token
	/// - Returns: Signed JWT
	private func buildRefreshToken() throws -> String? {
		let epochTime = Date(timeIntervalSince1970: TimeInterval(Int(Date().timeIntervalSince1970)))
		let claims = JWTClaims(iat: epochTime, sub: (RizeSDK.config?.programUID)!)
		let jwtSigner = JWTSigner.hs512(key: (RizeSDK.config?.hmacKey?.data(using: .utf8))!)
		var jwt = JWT(claims: claims)
		guard let signedJWT = try? jwt.sign(using: jwtSigner) else {
			Utils.logger("Error building refresh token")
			throw JWTError.invalidJWTString
		}

		return signedJWT
	}
}
