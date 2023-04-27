<p align="center">
  <a href="https://developer.rizefs.com/" target="_blank" align="center">
    <img src="https://cdn.rizefs.com/web-content/logos/rize-github.png" width="200">
  </a>
  <br />
</p>

# Rize Swift SDK

Rize makes financial services simple and accessible by enabling fintechs, financial institutions and brands to build across multiple account types with one API. The Rize Swift SDK enables access to all platform services in our sandbox, integration and production environments.

When you're ready to build, [open a sandbox environment](https://rizefs.com/get-access/). If you have questions, feedback, or a use case you want to discuss with us, contact us at [hello@rizemoney.com](mailto:hello@rizemoney.com).

For more information, check out our [Platform API Documentation](https://developer.rizefs.com/).

### Supported iOS Versions

The Rize Swift SDK is compatible with the two most recent, major iOS releases.

We currently support **iOS v15 and higher**.

## Getting Started

### Configuration

The SDK requires program configuration credentials in order to interact with the API.

You can find these in the [**Rize Admin Portal**](https://admin-sandbox.rizefs.com/).

| Parameter   | Description                                                  | Default   |
| ----------- | ------------------------------------------------------------ | --------- |
| HMACKey     | HMAC key for the target environment | "" |
| ProgramUID  | Program UID for the target environment | "" |
| Environment | The Rize environment to be used:<br> `"sandbox"`, `"integration"` or `"production"` | "sandbox" |

### Add the SDK as a Package Dependency

Add the Rize Swift SDK to your project using Swift Package Manager.

`.package(url: "https://github.com/RizeFinance/rize-swift-sdk", from: "1.0.0")`

### Import and Initialize

```swift
import RizeSDK

struct Rize {
	static var client: RizeSDK?
	static var config: RizeConfig?

	init() {
		self.config = try? RizeConfig(
			programUID: "PROGRAM_UID",
			hmacKey: "HMAC_KEY",
			environment: RizeEnvironments.sandbox
		)
		self.client = RizeSDK(config: self.config!)
	}

	func getCustomer(uid: String) async -> Customer? {
		let customer = try? await RizeSDK.client?.customers.get(uid: uid)
	}
}
```

## Tests

### Configure SwiftLint (optional)

```sh
$ brew install swiftlint

# Set xcode-select path
$ xcode-select -s /Applications/Xcode.app/Contents/Developer/
```

Add a new Run Script to the `Build` phase of the RizeSDK scheme:

`Product Menu` > `Edit Scheme` > `Build` > `Pre-Action` > `Add` > `New Run Script Action` 

```sh
if which swiftlint > /dev/null; then
  swiftlint
fi
```

### Run Mock Server API

The SDK uses [Prism](https://docs.stoplight.io/docs/prism) as a mock server for validation testing. You must start the Docker container before running the SDK tests.

`docker compose up`

## Documentation

* [Platform API Documentation](https://developer.rizefs.com/)
* [Message Queue Documentation](https://developer.rizefs.com/docs/rize-message-queue)
* [Rize Postman](https://www.postman.com/rizemoney/)
* [Rize GitHub](https://github.com/RizeFinance)
* [Rize JS SDK](https://github.com/RizeFinance/rize-js)
* [Rize Go SDK](https://github.com/RizeFinance/rize-go-sdk)
* [Rize Website](https://www.rizemoney.com/)

## License
MIT License. Copyright 2023-Present Rize Money, Inc. All rights reserved.

See [LICENSE](LICENSE)
