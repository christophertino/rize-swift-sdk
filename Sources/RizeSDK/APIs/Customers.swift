//
// Customers API
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal struct Customers {
	private let decoder = JSONDecoder()

	internal init() {
		self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
	}

	/// Retrieves a list of Customers filtered by the given parameters
	/// - Parameter query: CustomerListParams
	/// - Returns: CustomerList
	internal func list(query: CustomerListParams) async throws -> CustomerList? {
		let params = query.encodeURLQueryItem
		let data = try await HTTPService().doRequest(method: "GET", path: "customers", query: params, body: nil)
		let response = try self.decoder.decode(CustomerList.self, from: data!)
		return response
	}

	/// Used to initialize a new Customer with an email and external_uid
	/// - Parameter body: CustomerCreateParams
	/// - Throws: HTTPServiceError
	/// - Returns: Customer
	internal func create(body: CustomerCreateParams) async throws -> Customer? {
		if body.customer_type == "secondary" && body.primary_customer_uid.isEmptyOrNil {
			throw HTTPServiceError.invalidBodyParameters(description: "primary_customer_uid is required for secondary customers")
		}

		let params = try JSONEncoder().encode(body)
		let data = try await HTTPService().doRequest(method: "POST", path: "customers", query: nil, body: params)
		let response = try self.decoder.decode(Customer.self, from: data!)

		return response
	}

	/// Retrieves overall status about a Customer as well as their total Asset Balances across all accounts
	/// - Parameter uid: Customer UID
	/// - Throws: HTTPServiceError
	/// - Returns: Customer
	internal func get(uid: String) async throws -> Customer? {
		if uid == "" {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let data = try await HTTPService().doRequest(method: "GET", path: "customers/\(uid)", query: nil, body: nil)
		let response = try self.decoder.decode(Customer.self, from: data!)

		return response
	}

	///  Submit or update a Customer's personally identifiable information (PII) after they are created
	/// - Parameters:
	///   - uid: Customer UID
	///   - body:  CustomerUpdateParams
	/// - Throws: HTTPServiceError
	/// - Returns: Customer
	internal func update(uid: String, body: CustomerUpdateParams) async throws -> Customer? {
		if uid == "" {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let params = try JSONEncoder().encode(body)
		let data = try await HTTPService().doRequest(method: "PUT", path: "customers/\(uid)", query: nil, body: params)
		let response = try self.decoder.decode(Customer.self, from: data!)
		return response
	}

	/// Archive a Customer
	/// - Parameters:
	///   - uid: Customer UID
	///   - query: CustomerDeleteParams
	/// - Throws: HTTPServiceError
	/// - Returns: Data
	internal func delete(uid: String, body: CustomerDeleteParams) async throws -> Data? {
		if uid == "" {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let params = try JSONEncoder().encode(body)
		let data = try await HTTPService().doRequest(method: "DELETE", path: "customers/\(uid)", query: nil, body: params)
		return data
	}

	/// Used to explicitly confirm a Customer's PII data is up-to-date in order to add additional products
	/// - Parameter uid: Customer UID
	/// - Throws: HTTPServiceError
	/// - Returns: Customer
	internal func confirmPIIData(uid: String) async throws -> Customer? {
		if uid == "" {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let data = try await HTTPService().doRequest(method: "PUT", path: "customers/\(uid)/identity_confirmation", query: nil, body: nil)
		let response = try self.decoder.decode(Customer.self, from: data!)
		return response
	}

	/// Freeze all activities relating to the Customer
	/// - Parameters:
	///   - uid: Customer UID
	///   - query: CustomerLockParams
	/// - Throws: HTTPServiceError
	/// - Returns: Customer
	internal func lock(uid: String, body: CustomerLockParams) async throws -> Customer? {
		if uid == "" || body.lock_reason.isEmptyOrNil {
			throw HTTPServiceError.invalidQueryParameters(description: "UID and LockReason are required")
		}

		let params = try JSONEncoder().encode(body)
		let data = try await HTTPService().doRequest(method: "PUT", path: "customers/\(uid)/lock", query: nil, body: params)
		let response = try self.decoder.decode(Customer.self, from: data!)
		return response
	}

	/// Remove the Customer lock, returning their state to normal
	/// - Parameters:
	///   - uid: Customer UID
	///   - query: CustomerLockParams
	/// - Returns: Customer
	internal func unlock(uid: String, body: CustomerLockParams) async throws -> Customer? {
		if uid == "" {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		let params = try JSONEncoder().encode(body)
		let data = try await HTTPService().doRequest(method: "PUT", path: "customers/\(uid)/unlock", query: nil, body: params)
		let response = try self.decoder.decode(Customer.self, from: data!)
		return response
	}

	/// UpdateProfileResponses is used to submit a Customer's Profile Responses to Profile Requirements.. For most cases, use CustomerProfileResponseItem.Response to submit a string response. For ordered list type responses, use CustomerProfileResponseItem.Num0/1/2
	/// - Parameters:
	///   - uid: Customer UID
	///   - query: CustomerProfileResponseParams
	/// - Returns: Customer
	internal func updateProfileResponses(uid: String, body: [CustomerProfileResponseParams]) async throws -> Customer? {
		if uid == "" {
			throw HTTPServiceError.invalidQueryParameters(description: "UID is required")
		}

		for val in body {
			if val.profile_requirement_uid.isEmptyOrNil || (val.profile_response.isEmptyOrNil) {
				throw HTTPServiceError.invalidQueryParameters(description: "ProfileRequirementUID and ProfileResponse are required")

			}
		}

		// Wrap profile response params in a `details` json object
		struct BodyDetails: Encodable {
			var details: [CustomerProfileResponseParams]
		}
		let bds = BodyDetails(details: body)

		let params = try JSONEncoder().encode(bds)
		let data = try await HTTPService().doRequest(method: "PUT", path: "customers/\(uid)/update_profile_responses", query: nil, body: params)
		let response = try self.decoder.decode(Customer.self, from: data!)
		return response
	}
}
