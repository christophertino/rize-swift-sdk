//
// Extensions
// 
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

extension Optional where Wrapped: Collection {
	var isEmptyOrNil: Bool {
		return self?.isEmpty ?? true
	}
}
