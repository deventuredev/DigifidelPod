// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: RewardClaim.proto
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

struct RewardClaimProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var message: String = String()

  var ruleLimitMessage: String = String()

  var expirationDate: String = String()

  var redeemType: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension RewardClaimProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "RewardClaimProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "message"),
    2: .standard(proto: "rule_limit_message"),
    3: .same(proto: "expirationDate"),
    4: .standard(proto: "redeem_type"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.message) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.ruleLimitMessage) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.expirationDate) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self.redeemType) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.message.isEmpty {
      try visitor.visitSingularStringField(value: self.message, fieldNumber: 1)
    }
    if !self.ruleLimitMessage.isEmpty {
      try visitor.visitSingularStringField(value: self.ruleLimitMessage, fieldNumber: 2)
    }
    if !self.expirationDate.isEmpty {
      try visitor.visitSingularStringField(value: self.expirationDate, fieldNumber: 3)
    }
    if self.redeemType != 0 {
      try visitor.visitSingularInt32Field(value: self.redeemType, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: RewardClaimProto, rhs: RewardClaimProto) -> Bool {
    if lhs.message != rhs.message {return false}
    if lhs.ruleLimitMessage != rhs.ruleLimitMessage {return false}
    if lhs.expirationDate != rhs.expirationDate {return false}
    if lhs.redeemType != rhs.redeemType {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
