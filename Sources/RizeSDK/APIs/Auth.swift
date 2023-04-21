//
// Auth API
// 
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import SwiftJWT
import Foundation

/// Custom error for AuthService
public enum AuthServiceError: Error {
	case nilToken
}

/// TokenCache stores Auth token data
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
	/// - Returns: AuthToken
	internal func getToken() async throws -> AuthToken? {
		if TokenCache.shared.token.isEmptyOrNil || isExpired() {
			Utils.logger("Token is expired or does not exist. Fetching new token...")

			let refreshToken = try buildRefreshToken()
			TokenCache.shared.token = refreshToken

			let data = try await HTTPService().doRequest(method: "POST", path: "auth", query: nil, body: nil)
			let response = try? JSONDecoder().decode(AuthToken.self, from: data)

			// Validate token exists
			guard let token = response?.token else {
				Utils.logger("Token is nil")
				throw AuthServiceError.nilToken
			}

			// Save token to cache. Auth token is valid for 24hrs
			TokenCache.shared.token = token
			TokenCache.shared.timestamp = Int64(Date().timeIntervalSince1970)
			return response
		}
		return AuthToken(token: TokenCache.shared.token!)
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

	/// Checks to see if the current Auth token should be refreshed
	/// - Returns: Bool
	private func isExpired() -> Bool {
		let currentTime = Int64(Date().timeIntervalSince1970)
		let cache = TokenCache.shared
		guard let timestamp = cache.timestamp, (currentTime - timestamp) > Constants().tokenMaxAge else {
			return false
		}
		return true
	}
}
