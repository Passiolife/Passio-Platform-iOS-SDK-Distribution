# Passio Platform iOS SDK Release Notes


## Version 2.3.1

Released via swift package. 

## Version 2.2.15

* If the SDK was configured with a certain version and you need to install previous version, in your  PassioConfiguration set overrideInstalledVersion to true.

```swift
var passioConfig = PassioConfiguration(key: "Your Key")
passioConfig.projectID = "Your Project ID"
passioConfig.overrideInstalledVersion = true
```
* MetaData was made public
* Front camera can be used for detection


## Version  2.2.2

Base Passio Platform iOS SDK release
