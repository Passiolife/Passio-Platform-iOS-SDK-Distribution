# Passio PassioPlatformAISDK 

## Version  2.2.15
```Swift
import ARKit
import AVFoundation
import Accelerate
import CommonCrypto
import CoreML
import CoreMedia
import CoreMotion
import Foundation
import Metal
import MetalPerformanceShaders
import SQLite3
import SwiftUI
import UIKit
import VideoToolbox
import Vision
import _Concurrency
import _StringProcessing
import simd

public struct ArchitectureStructure : Codable {

    public let modelName: String?

    public let modelId: String?

    public let datasetId: String?

    public let trainingRunId: String?

    public let filename: PassioPlatformSDK.FileName?

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

/// The CustomCandidate protocol returns custom object detection candidate
public protocol DetectionCandidate {

    var label: String? { get }

    var passioID: PassioPlatformSDK.PassioID { get }

    /// Confidence (0.0 to 1.0) of the associated PassioID recognized by the MLModel
    var confidence: Double { get }

    /// boundingBox CGRect representing the predicted bounding box in normalized coordinates.
    var boundingBox: CGRect? { get }

    /// The image that the detection was preformed upon
    var croppedImage: UIImage? { get }
}

/// Implement the CustomObjectDetectionDelegate protocol to receive delegate methods from the object detection
public protocol DetectionDelegate : AnyObject {

    /// Delegate for CustomDetection
    /// - Parameters:
    ///   - candicates: DetectionCandidate
    ///   - image: Image used for detection
    func detectionResult(candidates: [PassioPlatformSDK.DetectionCandidate]?, image: UIImage?)
}

public struct EnsembleArchitecture : Codable {

    public let name: String

    public let structure: [PassioPlatformSDK.ArchitectureStructure]

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

public typealias FileLocalURL = URL

public typealias FileName = String

public enum IconSize : String {

    case px90

    case px180

    case px360

    /// Creates a new instance with the specified raw value.
    ///
    /// If there is no value of the type that corresponds with the specified raw
    /// value, this initializer returns `nil`. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     print(PaperSize(rawValue: "Legal"))
    ///     // Prints "Optional("PaperSize.Legal")"
    ///
    ///     print(PaperSize(rawValue: "Tabloid"))
    ///     // Prints "nil"
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    public init?(rawValue: String)

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = String

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public var rawValue: String { get }
}

extension IconSize : Equatable {
}

extension IconSize : Hashable {
}

extension IconSize : RawRepresentable {
}

public struct LabelMetaData : Codable {

    public let displayName: String?

    public let synonyms: [String : [PassioPlatformSDK.SynonymLang]]?

    public let models: [String]?

    public let labelId: String

    public let description: String?

    public var modelName: String? { get }

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

/// PassioConfiguration is needed configure the SDK with the following options:
public struct PassioConfiguration : Equatable {

    /// This is the key you have received from Passio. A valid key must be used.
    public var key: String

    /// If you have chosen to remove the files from the SDK and provide the SDK different URLs for this files please use this variable.
    public var filesLocalURLs: [PassioPlatformSDK.FileLocalURL]?

    /// Only use provided models. Don't use models previously installed.
    public var overrideInstalledVersion: Bool

    /// If you have problems configuring the SDK, set debugMode = 1 to get more debugging information.
    public var debugMode: Int

    public var projectID: String?

    public init(key: String)

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PassioPlatformSDK.PassioConfiguration, b: PassioPlatformSDK.PassioConfiguration) -> Bool
}

/// PassioID (typealias String) is and idetifier used throughout the SDK.
public typealias PassioID = String

public struct PassioMetadata : Codable {

    public let projectId: String

    public let ensembleId: String?

    public let ensembleVersion: Int?

    public let architecture: PassioPlatformSDK.EnsembleArchitecture?

    public var labelMetadata: [PassioPlatformSDK.PassioID : PassioPlatformSDK.LabelMetaData]? { get }

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

public struct PassioMetadataService {

    public var passioMetadata: PassioPlatformSDK.PassioMetadata? { get }

    public var getModelNames: [String]? { get }

    public var getlabelIcons: [PassioPlatformSDK.PassioID : PassioPlatformSDK.PassioID]? { get }

    public func getPassioIDs(byModelName: String) -> [PassioPlatformSDK.PassioID]?

    public func getLabel(passioID: PassioPlatformSDK.PassioID, languageCode: String = "en") -> String?

    public init(metatadataURL: URL? = nil)
}

/// PassioMode will report the mode the SDK is currently in.
public enum PassioMode {

    case notReady

    case isBeingConfigured

    case isDownloadingModels

    case isReadyForDetection

    case failedToConfigure

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PassioPlatformSDK.PassioMode, b: PassioPlatformSDK.PassioMode) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension PassioMode : Equatable {
}

extension PassioMode : Hashable {
}

/// Passio SDK - Copyright © 2022 Passio Inc. All rights reserved.
public class PassioPlatformAISDK {

    /// Shared Instance
    public class var shared: PassioPlatformSDK.PassioPlatformAISDK { get }

    /// Get the PassioStatus directly or implement the PassioStatusDelegate for updates.
    public var status: PassioPlatformSDK.PassioStatus { get }

    /// Delegate to track PassioStatus changes. You will get the same status via the configure function.
    weak public var statusDelegate: PassioPlatformSDK.PassioStatusDelegate?

    /// Available frames per seconds
    public enum FramesPerSecond : Int32 {

        case one

        case two

        case three

        case four

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional("PaperSize.Legal")"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: Int32)

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        public typealias RawValue = Int32

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: Int32 { get }
    }

    /// Call this API to configure the SDK
    /// - Parameters:
    ///   - PassioConfiguration: Your desired configuration, must include your developer key
    ///   - completion: Receive back the status of the SDK
    @available(iOS 13.0, *)
    public func configure(passioConfiguration: PassioPlatformSDK.PassioConfiguration, completion: @escaping (PassioPlatformSDK.PassioStatus) -> Void)

    /// Shut down the Passio SDK and release all resources
    public func shutDownPassioSDK()

    @available(iOS 13.0, *)
    public func startDetection(detectionDelegate: PassioPlatformSDK.DetectionDelegate, completion: @escaping (Bool) -> Void)

    public func stopDetection()

    public func getPreviewLayer(frontCamera: Bool = false) -> AVCaptureVideoPreviewLayer?

    /// Don't call this function if you need to use the Passio layer again. Only call this function to set the PassioSDK Preview layer to nil
    public func removeVidoeLayer()

    /// Use this function to get the bounding box relative to the previewLayerBonds
    /// - Parameter boundingBox: The bounding box from the delegate
    /// - Parameter preview: The preview layer bounding box
    public func transformCGRectForm(boundingBox: CGRect, toRect: CGRect) -> CGRect

    /// Fetch icons from the web.
    /// - Parameters:
    ///   - passioID: PassioIC
    ///   - size: 90, 180 or 360 px
    ///   - entityType: PassioEntityType to return the right placeholder.
    ///   - completion: Optional Icon.
    public func fetchIconFor(passioID: PassioPlatformSDK.PassioID, size: PassioPlatformSDK.IconSize = IconSize.px90, completion: @escaping (UIImage?) -> Void)

    public var version: String { get }
}

extension PassioPlatformAISDK : PassioPlatformSDK.PassioStatusDelegate {

    public func completedDownloadingAllFiles(filesLocalURLs: [PassioPlatformSDK.FileLocalURL])

    public func completedDownloadingFile(fileLocalURL: PassioPlatformSDK.FileLocalURL, filesLeft: Int)

    public func downloadingError(message: String)

    public func passioStatusChanged(status: PassioPlatformSDK.PassioStatus)

    public func passioProcessing(filesLeft: Int)
}

extension PassioPlatformAISDK.FramesPerSecond : Equatable {
}

extension PassioPlatformAISDK.FramesPerSecond : Hashable {
}

extension PassioPlatformAISDK.FramesPerSecond : RawRepresentable {
}

/// PassioSDKError will return the error with errorDescription if the configuration has failed. 
public enum PassioSDKError : LocalizedError {

    case canNotRunOnSimulator

    case keyNotValid

    case licensedKeyHasExpired

    case modelsNotValid

    case modelsDownloadFailed

    case noModelsFilesFound

    case noInternetConnection

    case notLicensedForThisProject

    /// A localized message describing what error occurred.
    public var errorDescription: String? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PassioPlatformSDK.PassioSDKError, b: PassioPlatformSDK.PassioSDKError) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension PassioSDKError : Equatable {
}

extension PassioSDKError : Hashable {
}

/// PassioStatus is returned at the end of the configuration of the SDK.
public struct PassioStatus {

    /// The mode had several values . isReadyForDetection is full success
    public var mode: PassioPlatformSDK.PassioMode { get }

    /// A string with more verbose information related to the configuration of the SDK
    public var debugMessage: String? { get }

    /// The error in case the SDK failed to configure
    public var error: PassioPlatformSDK.PassioSDKError? { get }

    /// The version of the latest models that are now used by the SDK.
    public var activeModels: Int? { get }

    public var projectID: String? { get }
}

/// Implement the protocol to receive status updates
public protocol PassioStatusDelegate : AnyObject {

    func passioStatusChanged(status: PassioPlatformSDK.PassioStatus)

    func passioProcessing(filesLeft: Int)

    func completedDownloadingAllFiles(filesLocalURLs: [PassioPlatformSDK.FileLocalURL])

    func completedDownloadingFile(fileLocalURL: PassioPlatformSDK.FileLocalURL, filesLeft: Int)

    func downloadingError(message: String)
}

public typealias ProjectID = String

public struct SynonymLang : Codable {

    public let synonym: String?

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

extension UIImageView {

    @MainActor public func loadPassioIconBy(passioID: PassioPlatformSDK.PassioID, size: PassioPlatformSDK.IconSize = .px90, completion: @escaping (PassioPlatformSDK.PassioID, UIImage) -> Void)
}

extension simd_float4x4 : ContiguousBytes {

    /// Calls the given closure with the contents of underlying storage.
    ///
    /// - note: Calling `withUnsafeBytes` multiple times does not guarantee that
    ///         the same buffer pointer will be passed in every time.
    /// - warning: The buffer argument to the body should not be stored or used
    ///            outside of the lifetime of the call to the closure.
    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R
}

infix operator .+ : DefaultPrecedence

infix operator ./ : DefaultPrecedence


```
<sup>Copyright 2022 Passio Inc</sup>
