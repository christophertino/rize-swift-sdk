//
// Extensions
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
	var isEmptyOrNil: Bool {
		return self?.isEmpty ?? true
	}
}

extension Encodable {
	/// Convert encodable struct to dictionary
	var dictionary: [String: Any?]? {
		guard let data = try? JSONEncoder().encode(self) else {
			return nil
		}
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap {
			$0 as? [String: Any?]
		}
	}
	// Convert encodable struct to URLQueryItem list
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
