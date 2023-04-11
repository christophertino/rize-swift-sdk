//
// Utils
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// Shared utilities
internal struct Utils {
	/// Custom debug logging function
	/// - Parameters:
	///   - object: The log message
	static func logger<T>(_ object: T) {
		#if DEBUG
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
			Swift.print("\(dateFormatter.string(from: Foundation.Date())) >> \(object)")
		#endif
	}
}
