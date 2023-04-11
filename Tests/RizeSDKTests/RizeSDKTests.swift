import XCTest
@testable import RizeSDK

final class RizeSDKTests: XCTestCase {
	private static var config = RizeConfig(
		ProgramUID: "",
		HMACKey: "",
		Environment: "staging",
		BaseURL: "https://sandbox.rizefs.com",
		Debug: true
	)

	/// Set up any overall initial state for all test cases
	override class func setUp() {
		
	}
}
