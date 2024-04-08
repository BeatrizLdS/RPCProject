// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: game.proto
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

struct Game_User {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Game_GameState {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var state: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Game_Move {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var moveFrom: Int32 = 0

  var moveTo: Int32 = 0

  var removed: Int32 = 0

  var endGame: Bool = false

  var restartGame: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Game_Empty {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Game_User: @unchecked Sendable {}
extension Game_GameState: @unchecked Sendable {}
extension Game_Move: @unchecked Sendable {}
extension Game_Empty: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "game"

extension Game_User: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".User"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Game_User, rhs: Game_User) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Game_GameState: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GameState"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "state"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.state) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.state.isEmpty {
      try visitor.visitSingularStringField(value: self.state, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Game_GameState, rhs: Game_GameState) -> Bool {
    if lhs.state != rhs.state {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Game_Move: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Move"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "moveFrom"),
    2: .same(proto: "moveTo"),
    3: .same(proto: "removed"),
    4: .same(proto: "endGame"),
    5: .same(proto: "restartGame"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.moveFrom) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.moveTo) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.removed) }()
      case 4: try { try decoder.decodeSingularBoolField(value: &self.endGame) }()
      case 5: try { try decoder.decodeSingularBoolField(value: &self.restartGame) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.moveFrom != 0 {
      try visitor.visitSingularInt32Field(value: self.moveFrom, fieldNumber: 1)
    }
    if self.moveTo != 0 {
      try visitor.visitSingularInt32Field(value: self.moveTo, fieldNumber: 2)
    }
    if self.removed != 0 {
      try visitor.visitSingularInt32Field(value: self.removed, fieldNumber: 3)
    }
    if self.endGame != false {
      try visitor.visitSingularBoolField(value: self.endGame, fieldNumber: 4)
    }
    if self.restartGame != false {
      try visitor.visitSingularBoolField(value: self.restartGame, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Game_Move, rhs: Game_Move) -> Bool {
    if lhs.moveFrom != rhs.moveFrom {return false}
    if lhs.moveTo != rhs.moveTo {return false}
    if lhs.removed != rhs.removed {return false}
    if lhs.endGame != rhs.endGame {return false}
    if lhs.restartGame != rhs.restartGame {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Game_Empty: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Empty"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Game_Empty, rhs: Game_Empty) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

