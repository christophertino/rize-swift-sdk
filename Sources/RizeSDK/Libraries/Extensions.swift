//
// Extensions
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

internal extension Optional where Wrapped: Collection {
	var isEmptyOrNil: Bool {
		return self?.isEmpty ?? true
	}
}

internal extension Encodable {
	/// Convert encodable struct to dictionary
	var dictionary: [String: Any?]? {
		guard let data = try? JSONEncoder().encode(self) else {
			return nil
		}
		// Serialize to dictionary
		let dict = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any?]
		// Make sure that Bool values are true/false instead of 0/1
		return dict?.reduce(into: [String: Any?](), { (result, item) in
			if let num = dict?[item.key] as? NSNumber {
				switch CFGetTypeID(num as CFTypeRef) {
					case CFBooleanGetTypeID():
						result[item.key] = item.value as? Bool
					default:
						result[item.key] = item.value
				}
				return
			}
			result[item.key] = item.value
		})
	}
	/// Convert encodable struct to URLQueryItem list
	var encodeURLQueryItem: [URLQueryItem]? {
		let destination = self.dictionary?.filter({ $0.value != nil}).reduce(into: [URLQueryItem]()) { (result, item) in
			if let collection = item.value as? [Any?] {
				let value = collection.filter({ $0 != nil }).map({"\($0!)"}).joined(separator: ",")
				result.append(URLQueryItem(name: item.key, value: value))
			} else if let value = item.value {
				result.append(URLQueryItem(name: item.key, value: "\(value)"))
			}
		}

		guard let dest = destination, !dest.isEmpty else {
			return nil
		}

		return destination
	}
}

internal extension Formatter {
	/// Build custom date formatter to match Rize API date format
	static let iso8601: DateFormatter = {
		let formatter = DateFormatter()
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
		return formatter
	}()
}
