<p align="center">
  <a href="https://developer.rizefs.com/" target="_blank" align="center">
    <img src="https://cdn.rizefs.com/web-content/logos/rize-github.png" width="200">
  </a>
  <br />
</p>

# Rize iOS Swift SDK

Rize makes financial services simple and accessible by enabling fintechs, financial institutions and brands to build across multiple account types with one API. The Rize iOS SDK enables access to all platform services in our sandbox, integration and production environments.

When you're ready to build, [open a sandbox environment](https://rizefs.com/get-access/). If you have questions, feedback, or a use case you want to discuss with us, contact us at [hello@rizemoney.com](mailto:hello@rizemoney.com).

For more information, check out our [Platform API Documentation](https://developer.rizefs.com/).

### Supported iOS Versions

The Rize iOS SDK is compatible with the two most recent, major iOS releases.

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
| Debug  | Enable debug logging | false |

### Add a Dependency

Add the Rize iOS SDK to your project using Swift Package Manager.

```swift
import RizeSDK

struct Rize {
	static var client: RizeSDK?
	static var config = RizeConfig(
		programUID: "PROGRAM_UID",
		hmacKey: "HMAC_KEY",
		environment: "sandbox"
	)
	init() {
		client = RizeSDK(config: config)
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

### Set Environment Variables

The `RizeSDKTests` target requires the following environment variables to be set on the `Run` phase of the RizeSDK scheme. 

+ PROGRAM_UID
+ HMAC_KEY
+ ENVIRONMENT

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
