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
	let token: String
}

// TokenCache stores Auth token data
internal struct TokenCache {
	var token: String?
	var timestamp: Int64?
	static var shared = TokenCache(token: nil, timestamp: nil)
}

public struct Auth {
	/// GetToken generates an authorization token if the existing token is expired or not found.
	/// Otherwise, it will return the existing active token,
	public func getToken() {
		if TokenCache.shared.token.isEmptyOrNil {
			Utils.logger("Token is expired or does not exist. Fetching new token...")

			do {
				let refreshToken = try buildRefreshToken()
				TokenCache.shared.token = refreshToken
			} catch {
				Utils.logger("Error building refresh token: \(error.localizedDescription)")
				return
			}

			HTTPService.doRequest(method: "POST", path: "auth", query: nil, body: nil) { result in
				switch result {
					case .success(let data):
						if let response = try? JSONDecoder().decode([AuthTokenResponse].self, from: data) {
							Utils.logger("Token response \(response)")
							// Validate token exists
							
							//  Save token to cache. Auth token is valid for 24hrs
						} else {
							// error
						}
					case .failure(let error):
						print(error.localizedDescription)
				}
			}
		}
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
