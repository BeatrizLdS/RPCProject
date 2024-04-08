//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: game.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Game_GameServiceClient`, then call methods of this protocol to make API calls.
internal protocol Game_GameServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Game_GameServiceClientInterceptorFactoryProtocol? { get }

  func connect(
    _ request: Game_User,
    callOptions: CallOptions?
  ) -> UnaryCall<Game_User, Game_Empty>

  func stateStream(
    _ request: Game_Empty,
    callOptions: CallOptions?,
    handler: @escaping (Game_GameState) -> Void
  ) -> ServerStreamingCall<Game_Empty, Game_GameState>
}

extension Game_GameServiceClientProtocol {
  internal var serviceName: String {
    return "game.GameService"
  }

  /// Unary call to Connect
  ///
  /// - Parameters:
  ///   - request: Request to send to Connect.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func connect(
    _ request: Game_User,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Game_User, Game_Empty> {
    return self.makeUnaryCall(
      path: Game_GameServiceClientMetadata.Methods.connect.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectInterceptors() ?? []
    )
  }

  /// Server streaming call to StateStream
  ///
  /// - Parameters:
  ///   - request: Request to send to StateStream.
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  internal func stateStream(
    _ request: Game_Empty,
    callOptions: CallOptions? = nil,
    handler: @escaping (Game_GameState) -> Void
  ) -> ServerStreamingCall<Game_Empty, Game_GameState> {
    return self.makeServerStreamingCall(
      path: Game_GameServiceClientMetadata.Methods.stateStream.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStateStreamInterceptors() ?? [],
      handler: handler
    )
  }
}

@available(*, deprecated)
extension Game_GameServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Game_GameServiceNIOClient")
internal final class Game_GameServiceClient: Game_GameServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Game_GameServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Game_GameServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the game.GameService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Game_GameServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Game_GameServiceNIOClient: Game_GameServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Game_GameServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the game.GameService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Game_GameServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Game_GameServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Game_GameServiceClientInterceptorFactoryProtocol? { get }

  func makeConnectCall(
    _ request: Game_User,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Game_User, Game_Empty>

  func makeStateStreamCall(
    _ request: Game_Empty,
    callOptions: CallOptions?
  ) -> GRPCAsyncServerStreamingCall<Game_Empty, Game_GameState>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Game_GameServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Game_GameServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Game_GameServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeConnectCall(
    _ request: Game_User,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Game_User, Game_Empty> {
    return self.makeAsyncUnaryCall(
      path: Game_GameServiceClientMetadata.Methods.connect.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectInterceptors() ?? []
    )
  }

  internal func makeStateStreamCall(
    _ request: Game_Empty,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncServerStreamingCall<Game_Empty, Game_GameState> {
    return self.makeAsyncServerStreamingCall(
      path: Game_GameServiceClientMetadata.Methods.stateStream.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStateStreamInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Game_GameServiceAsyncClientProtocol {
  internal func connect(
    _ request: Game_User,
    callOptions: CallOptions? = nil
  ) async throws -> Game_Empty {
    return try await self.performAsyncUnaryCall(
      path: Game_GameServiceClientMetadata.Methods.connect.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectInterceptors() ?? []
    )
  }

  internal func stateStream(
    _ request: Game_Empty,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Game_GameState> {
    return self.performAsyncServerStreamingCall(
      path: Game_GameServiceClientMetadata.Methods.stateStream.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStateStreamInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Game_GameServiceAsyncClient: Game_GameServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Game_GameServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Game_GameServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Game_GameServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'connect'.
  func makeConnectInterceptors() -> [ClientInterceptor<Game_User, Game_Empty>]

  /// - Returns: Interceptors to use when invoking 'stateStream'.
  func makeStateStreamInterceptors() -> [ClientInterceptor<Game_Empty, Game_GameState>]
}

internal enum Game_GameServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "GameService",
    fullName: "game.GameService",
    methods: [
      Game_GameServiceClientMetadata.Methods.connect,
      Game_GameServiceClientMetadata.Methods.stateStream,
    ]
  )

  internal enum Methods {
    internal static let connect = GRPCMethodDescriptor(
      name: "Connect",
      path: "/game.GameService/Connect",
      type: GRPCCallType.unary
    )

    internal static let stateStream = GRPCMethodDescriptor(
      name: "StateStream",
      path: "/game.GameService/StateStream",
      type: GRPCCallType.serverStreaming
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Game_GameServiceProvider: CallHandlerProvider {
  var interceptors: Game_GameServiceServerInterceptorFactoryProtocol? { get }

  func connect(request: Game_User, context: StatusOnlyCallContext) -> EventLoopFuture<Game_Empty>

  func stateStream(request: Game_Empty, context: StreamingResponseCallContext<Game_GameState>) -> EventLoopFuture<GRPCStatus>
}

extension Game_GameServiceProvider {
  internal var serviceName: Substring {
    return Game_GameServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Connect":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Game_User>(),
        responseSerializer: ProtobufSerializer<Game_Empty>(),
        interceptors: self.interceptors?.makeConnectInterceptors() ?? [],
        userFunction: self.connect(request:context:)
      )

    case "StateStream":
      return ServerStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Game_Empty>(),
        responseSerializer: ProtobufSerializer<Game_GameState>(),
        interceptors: self.interceptors?.makeStateStreamInterceptors() ?? [],
        userFunction: self.stateStream(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Game_GameServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Game_GameServiceServerInterceptorFactoryProtocol? { get }

  func connect(
    request: Game_User,
    context: GRPCAsyncServerCallContext
  ) async throws -> Game_Empty

  func stateStream(
    request: Game_Empty,
    responseStream: GRPCAsyncResponseStreamWriter<Game_GameState>,
    context: GRPCAsyncServerCallContext
  ) async throws
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Game_GameServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Game_GameServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return Game_GameServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: Game_GameServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Connect":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Game_User>(),
        responseSerializer: ProtobufSerializer<Game_Empty>(),
        interceptors: self.interceptors?.makeConnectInterceptors() ?? [],
        wrapping: { try await self.connect(request: $0, context: $1) }
      )

    case "StateStream":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Game_Empty>(),
        responseSerializer: ProtobufSerializer<Game_GameState>(),
        interceptors: self.interceptors?.makeStateStreamInterceptors() ?? [],
        wrapping: { try await self.stateStream(request: $0, responseStream: $1, context: $2) }
      )

    default:
      return nil
    }
  }
}

internal protocol Game_GameServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'connect'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeConnectInterceptors() -> [ServerInterceptor<Game_User, Game_Empty>]

  /// - Returns: Interceptors to use when handling 'stateStream'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeStateStreamInterceptors() -> [ServerInterceptor<Game_Empty, Game_GameState>]
}

internal enum Game_GameServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "GameService",
    fullName: "game.GameService",
    methods: [
      Game_GameServiceServerMetadata.Methods.connect,
      Game_GameServiceServerMetadata.Methods.stateStream,
    ]
  )

  internal enum Methods {
    internal static let connect = GRPCMethodDescriptor(
      name: "Connect",
      path: "/game.GameService/Connect",
      type: GRPCCallType.unary
    )

    internal static let stateStream = GRPCMethodDescriptor(
      name: "StateStream",
      path: "/game.GameService/StateStream",
      type: GRPCCallType.serverStreaming
    )
  }
}

