// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: ProtoResponse.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct ProtoResponseModel {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var success: Bool = false

  var statusCode: Int32 = 0

  var message: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct AdShownProtoResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct AdTappedResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct ClaimResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var data: RewardClaimProto {
    get {return _data ?? RewardClaimProto()}
    set {_data = newValue}
  }
  /// Returns true if `data` has been explicitly set.
  var hasData: Bool {return self._data != nil}
  /// Clears the value of `data`. Subsequent reads from it will return its default value.
  mutating func clearData() {self._data = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
  fileprivate var _data: RewardClaimProto? = nil
}

struct EndSessionResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct GetCampaignsResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var data: [CampaignModelProto] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct GetNextAdImageResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var data: CampaignAdModelProto {
    get {return _data ?? CampaignAdModelProto()}
    set {_data = newValue}
  }
  /// Returns true if `data` has been explicitly set.
  var hasData: Bool {return self._data != nil}
  /// Clears the value of `data`. Subsequent reads from it will return its default value.
  mutating func clearData() {self._data = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
  fileprivate var _data: CampaignAdModelProto? = nil
}

struct GetTkTyByCampaignResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var dataList: [TokenTypeModelProto] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct GetTkTyByIdResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var data: TokenTypeDetailsModelProto {
    get {return _data ?? TokenTypeDetailsModelProto()}
    set {_data = newValue}
  }
  /// Returns true if `data` has been explicitly set.
  var hasData: Bool {return self._data != nil}
  /// Clears the value of `data`. Subsequent reads from it will return its default value.
  mutating func clearData() {self._data = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
  fileprivate var _data: TokenTypeDetailsModelProto? = nil
}

struct GetTokensByLocationResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var dataList: [MapTokenTypeProtoModel] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct GetTokensResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var dataList: [TokenTypeModelProto] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct GetWalletResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var dataList: [WalletModelProto] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
}

struct InitModelResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var data: InitModelProto {
    get {return _data ?? InitModelProto()}
    set {_data = newValue}
  }
  /// Returns true if `data` has been explicitly set.
  var hasData: Bool {return self._data != nil}
  /// Clears the value of `data`. Subsequent reads from it will return its default value.
  mutating func clearData() {self._data = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
  fileprivate var _data: InitModelProto? = nil
}

struct RedeemResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var data: TokenTypeDetailsModelProto {
    get {return _data ?? TokenTypeDetailsModelProto()}
    set {_data = newValue}
  }
  /// Returns true if `data` has been explicitly set.
  var hasData: Bool {return self._data != nil}
  /// Clears the value of `data`. Subsequent reads from it will return its default value.
  mutating func clearData() {self._data = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
  fileprivate var _data: TokenTypeDetailsModelProto? = nil
}

struct StartSessionResponseProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: ProtoResponseModel {
    get {return _response ?? ProtoResponseModel()}
    set {_response = newValue}
  }
  /// Returns true if `response` has been explicitly set.
  var hasResponse: Bool {return self._response != nil}
  /// Clears the value of `response`. Subsequent reads from it will return its default value.
  mutating func clearResponse() {self._response = nil}

  var data: StartSessionGetModelProto {
    get {return _data ?? StartSessionGetModelProto()}
    set {_data = newValue}
  }
  /// Returns true if `data` has been explicitly set.
  var hasData: Bool {return self._data != nil}
  /// Clears the value of `data`. Subsequent reads from it will return its default value.
  mutating func clearData() {self._data = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _response: ProtoResponseModel? = nil
  fileprivate var _data: StartSessionGetModelProto? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension ProtoResponseModel: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "ProtoResponseModel"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "success"),
    2: .same(proto: "statusCode"),
    3: .same(proto: "message"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBoolField(value: &self.success) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.statusCode) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.message) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.success != false {
      try visitor.visitSingularBoolField(value: self.success, fieldNumber: 1)
    }
    if self.statusCode != 0 {
      try visitor.visitSingularInt32Field(value: self.statusCode, fieldNumber: 2)
    }
    if !self.message.isEmpty {
      try visitor.visitSingularStringField(value: self.message, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: ProtoResponseModel, rhs: ProtoResponseModel) -> Bool {
    if lhs.success != rhs.success {return false}
    if lhs.statusCode != rhs.statusCode {return false}
    if lhs.message != rhs.message {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension AdShownProtoResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "AdShownProtoResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: AdShownProtoResponse, rhs: AdShownProtoResponse) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension AdTappedResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "AdTappedResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: AdTappedResponseProto, rhs: AdTappedResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension ClaimResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "ClaimResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._data {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: ClaimResponse, rhs: ClaimResponse) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs._data != rhs._data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension EndSessionResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "EndSessionResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: EndSessionResponseProto, rhs: EndSessionResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension GetCampaignsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GetCampaignsResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.data.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.data, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GetCampaignsResponse, rhs: GetCampaignsResponse) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.data != rhs.data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension GetNextAdImageResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GetNextAdImageResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._data {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GetNextAdImageResponseProto, rhs: GetNextAdImageResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs._data != rhs._data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension GetTkTyByCampaignResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GetTkTyByCampaignResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "dataList"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.dataList) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.dataList.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.dataList, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GetTkTyByCampaignResponseProto, rhs: GetTkTyByCampaignResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.dataList != rhs.dataList {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension GetTkTyByIdResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GetTkTyByIdResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._data {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GetTkTyByIdResponseProto, rhs: GetTkTyByIdResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs._data != rhs._data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension GetTokensByLocationResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GetTokensByLocationResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "dataList"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.dataList) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.dataList.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.dataList, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GetTokensByLocationResponse, rhs: GetTokensByLocationResponse) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.dataList != rhs.dataList {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension GetTokensResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GetTokensResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "dataList"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.dataList) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.dataList.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.dataList, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GetTokensResponseProto, rhs: GetTokensResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.dataList != rhs.dataList {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension GetWalletResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GetWalletResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "dataList"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.dataList) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.dataList.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.dataList, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GetWalletResponseProto, rhs: GetWalletResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs.dataList != rhs.dataList {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension InitModelResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "InitModelResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._data {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: InitModelResponse, rhs: InitModelResponse) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs._data != rhs._data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension RedeemResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "RedeemResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._data {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: RedeemResponseProto, rhs: RedeemResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs._data != rhs._data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension StartSessionResponseProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "StartSessionResponseProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "response"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._response) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._response {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._data {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: StartSessionResponseProto, rhs: StartSessionResponseProto) -> Bool {
    if lhs._response != rhs._response {return false}
    if lhs._data != rhs._data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}