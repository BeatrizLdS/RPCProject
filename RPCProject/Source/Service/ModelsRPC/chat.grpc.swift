//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: chat.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Chat_ChatServiceClient`, then call methods of this protocol to make API calls.
internal protocol Chat_ChatServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol? { get }

  func sendMessage(
    _ request: Chat_ChatMessage,
    callOptions: CallOptions?
  ) -> UnaryCall<Chat_ChatMessage, Chat_ChatMessage>

  func chatStream(
    _ request: Chat_Empty,
    callOptions: CallOptions?,
    handler: @escaping (Chat_ChatMessage) -> Void
  ) -> ServerStreamingCall<Chat_Empty, Chat_ChatMessage>
}

extension Chat_ChatServiceClientProtocol {
  internal var serviceName: String {
    return "chat.ChatService"
  }

  /// Unary call to SendMessage
  ///
  /// - Parameters:
  ///   - request: Request to send to SendMessage.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func sendMessage(
    _ request: Chat_ChatMessage,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Chat_ChatMessage, Chat_ChatMessage> {
    return self.makeUnaryCall(
      path: Chat_ChatServiceClientMetadata.Methods.sendMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendMessageInterceptors() ?? []
    )
  }

  /// Server streaming call to ChatStream
  ///
  /// - Parameters:
  ///   - request: Request to send to ChatStream.
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  internal func chatStream(
    _ request: Chat_Empty,
    callOptions: CallOptions? = nil,
    handler: @escaping (Chat_ChatMessage) -> Void
  ) -> ServerStreamingCall<Chat_Empty, Chat_ChatMessage> {
    return self.makeServerStreamingCall(
      path: Chat_ChatServiceClientMetadata.Methods.chatStream.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChatStreamInterceptors() ?? [],
      handler: handler
    )
  }
}

@available(*, deprecated)
extension Chat_ChatServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Chat_ChatServiceNIOClient")
internal final class Chat_ChatServiceClient: Chat_ChatServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the chat.ChatService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Chat_ChatServiceNIOClient: Chat_ChatServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the chat.ChatService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Chat_ChatServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol? { get }

  func makeSendMessageCall(
    _ request: Chat_ChatMessage,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Chat_ChatMessage, Chat_ChatMessage>

  func makeChatStreamCall(
    _ request: Chat_Empty,
    callOptions: CallOptions?
  ) -> GRPCAsyncServerStreamingCall<Chat_Empty, Chat_ChatMessage>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Chat_ChatServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Chat_ChatServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeSendMessageCall(
    _ request: Chat_ChatMessage,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Chat_ChatMessage, Chat_ChatMessage> {
    return self.makeAsyncUnaryCall(
      path: Chat_ChatServiceClientMetadata.Methods.sendMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendMessageInterceptors() ?? []
    )
  }

  internal func makeChatStreamCall(
    _ request: Chat_Empty,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncServerStreamingCall<Chat_Empty, Chat_ChatMessage> {
    return self.makeAsyncServerStreamingCall(
      path: Chat_ChatServiceClientMetadata.Methods.chatStream.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChatStreamInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Chat_ChatServiceAsyncClientProtocol {
  internal func sendMessage(
    _ request: Chat_ChatMessage,
    callOptions: CallOptions? = nil
  ) async throws -> Chat_ChatMessage {
    return try await self.performAsyncUnaryCall(
      path: Chat_ChatServiceClientMetadata.Methods.sendMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendMessageInterceptors() ?? []
    )
  }

  internal func chatStream(
    _ request: Chat_Empty,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Chat_ChatMessage> {
    return self.performAsyncServerStreamingCall(
      path: Chat_ChatServiceClientMetadata.Methods.chatStream.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChatStreamInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Chat_ChatServiceAsyncClient: Chat_ChatServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Chat_ChatServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Chat_ChatServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'sendMessage'.
  func makeSendMessageInterceptors() -> [ClientInterceptor<Chat_ChatMessage, Chat_ChatMessage>]

  /// - Returns: Interceptors to use when invoking 'chatStream'.
  func makeChatStreamInterceptors() -> [ClientInterceptor<Chat_Empty, Chat_ChatMessage>]
}

internal enum Chat_ChatServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "ChatService",
    fullName: "chat.ChatService",
    methods: [
      Chat_ChatServiceClientMetadata.Methods.sendMessage,
      Chat_ChatServiceClientMetadata.Methods.chatStream,
    ]
  )

  internal enum Methods {
    internal static let sendMessage = GRPCMethodDescriptor(
      name: "SendMessage",
      path: "/chat.ChatService/SendMessage",
      type: GRPCCallType.unary
    )

    internal static let chatStream = GRPCMethodDescriptor(
      name: "ChatStream",
      path: "/chat.ChatService/ChatStream",
      type: GRPCCallType.serverStreaming
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Chat_ChatServiceProvider: CallHandlerProvider {
  var interceptors: Chat_ChatServiceServerInterceptorFactoryProtocol? { get }

  func sendMessage(request: Chat_ChatMessage, context: StatusOnlyCallContext) -> EventLoopFuture<Chat_ChatMessage>

  func chatStream(request: Chat_Empty, context: StreamingResponseCallContext<Chat_ChatMessage>) -> EventLoopFuture<GRPCStatus>
}

extension Chat_ChatServiceProvider {
  internal var serviceName: Substring {
    return Chat_ChatServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SendMessage":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Chat_ChatMessage>(),
        responseSerializer: ProtobufSerializer<Chat_ChatMessage>(),
        interceptors: self.interceptors?.makeSendMessageInterceptors() ?? [],
        userFunction: self.sendMessage(request:context:)
      )

    case "ChatStream":
      return ServerStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Chat_Empty>(),
        responseSerializer: ProtobufSerializer<Chat_ChatMessage>(),
        interceptors: self.interceptors?.makeChatStreamInterceptors() ?? [],
        userFunction: self.chatStream(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Chat_ChatServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Chat_ChatServiceServerInterceptorFactoryProtocol? { get }

  func sendMessage(
    request: Chat_ChatMessage,
    context: GRPCAsyncServerCallContext
  ) async throws -> Chat_ChatMessage

  func chatStream(
    request: Chat_Empty,
    responseStream: GRPCAsyncResponseStreamWriter<Chat_ChatMessage>,
    context: GRPCAsyncServerCallContext
  ) async throws
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Chat_ChatServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Chat_ChatServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return Chat_ChatServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: Chat_ChatServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SendMessage":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Chat_ChatMessage>(),
        responseSerializer: ProtobufSerializer<Chat_ChatMessage>(),
        interceptors: self.interceptors?.makeSendMessageInterceptors() ?? [],
        wrapping: { try await self.sendMessage(request: $0, context: $1) }
      )

    case "ChatStream":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Chat_Empty>(),
        responseSerializer: ProtobufSerializer<Chat_ChatMessage>(),
        interceptors: self.interceptors?.makeChatStreamInterceptors() ?? [],
        wrapping: { try await self.chatStream(request: $0, responseStream: $1, context: $2) }
      )

    default:
      return nil
    }
  }
}

internal protocol Chat_ChatServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'sendMessage'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSendMessageInterceptors() -> [ServerInterceptor<Chat_ChatMessage, Chat_ChatMessage>]

  /// - Returns: Interceptors to use when handling 'chatStream'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeChatStreamInterceptors() -> [ServerInterceptor<Chat_Empty, Chat_ChatMessage>]
}

internal enum Chat_ChatServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "ChatService",
    fullName: "chat.ChatService",
    methods: [
      Chat_ChatServiceServerMetadata.Methods.sendMessage,
      Chat_ChatServiceServerMetadata.Methods.chatStream,
    ]
  )

  internal enum Methods {
    internal static let sendMessage = GRPCMethodDescriptor(
      name: "SendMessage",
      path: "/chat.ChatService/SendMessage",
      type: GRPCCallType.unary
    )

    internal static let chatStream = GRPCMethodDescriptor(
      name: "ChatStream",
      path: "/chat.ChatService/ChatStream",
      type: GRPCCallType.serverStreaming
    )
  }
}
