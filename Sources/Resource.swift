// Resource.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@_exported import Router
@_exported import ContentNegotiationMiddleware

public final class ResourceBuilder {
    public typealias RespondWithId = (request: Request, id: String) throws -> Response
    public typealias RespondWithContent = (request: Request, content: StructuredData) throws -> Response
    public typealias RespondWithIdContent = (request: Request, id: String, content: StructuredData) throws -> Response

    var mediaTypes: [MediaType] = []

    var index: Responder = BasicResponder { _ in
        return Response(status: .methodNotAllowed)
    }

    public func index(middleware: Middleware..., respond: Respond) {
        let responder = BasicResponder(respond)
        self.index = middleware.chain(to: responder)
    }

    var create: Responder = BasicResponder { _ in
        return Response(status: .methodNotAllowed)
    }

    public func create(middleware: Middleware..., respond: Respond) {
        let responder = BasicResponder(respond)
        self.create = middleware.chain(to: responder)
    }

    public func create(middleware: Middleware..., respond: RespondWithContent) {
        let responder = BasicResponder { request in
            guard let content = request.content else {
                return Response(status: .badRequest)
            }
            return try respond(request: request, content: content)
        }
        self.create = middleware.chain(to: responder)
    }

    public func create<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, content: T) throws -> Response) {
        let contentMapper = ContentMapperMiddleware(mappingTo: content)
        let responder = BasicResponder { request in
            let content = request.storage[T.key] as! T
            return try respond(request: request, content: content)
        }
        let middlewareChain: [Middleware] = [contentMapper] + middleware
        self.create = middlewareChain.chain(to: responder)
    }

    public func create<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, content: inout T) throws -> Response) {
        let contentMapper = ContentMapperMiddleware(mappingTo: content)
        let responder = BasicResponder { request in
            var content = request.storage[T.key] as! T
            return try respond(request: request, content: &content)
        }
        let middlewareChain: [Middleware] = [contentMapper] + middleware
        self.create = middlewareChain.chain(to: responder)
    }

    var show: Responder = BasicResponder { _ in
        return Response(status: .methodNotAllowed)
    }

    public func show(middleware: Middleware..., respond: RespondWithId) {
        let responder = BasicResponder { request in
            return try respond(request: request, id: request.id!)
        }
        self.show = middleware.chain(to: responder)
    }

    var update: Responder = BasicResponder { _ in
        return Response(status: .methodNotAllowed)
    }

    public func update(middleware: Middleware..., respond: RespondWithId) {
        let responder = BasicResponder { request in
            return try respond(request: request, id: request.id!)
        }
        self.update = middleware.chain(to: responder)
    }

    public func update(middleware: Middleware..., respond: RespondWithIdContent) {
        let responder = BasicResponder { request in
            guard let content = request.content else {
                return Response(status: .badRequest)
            }
            return try respond(request: request, id: request.id!, content: content)
        }
        self.update = middleware.chain(to: responder)
    }

    public func update<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, id: String, content: T) throws -> Response) {
        let contentMapper = ContentMapperMiddleware(mappingTo: content)
        let responder = BasicResponder { request in
            let content = request.storage[T.key] as! T
            return try respond(request: request, id: request.id!, content: content)
        }
        let middlewareChain: [Middleware] = [contentMapper] + middleware
        self.update = middlewareChain.chain(to: responder)
    }

    public func update<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, id: String, content: inout T) throws -> Response) {
        let contentMapper = ContentMapperMiddleware(mappingTo: content)
        let responder = BasicResponder { request in
            var content = request.storage[T.key] as! T
            return try respond(request: request, id: request.id!, content: &content)
        }
        let middlewareChain: [Middleware] = [contentMapper] + middleware
        self.update = middlewareChain.chain(to: responder)
    }

    var destroy: Responder = BasicResponder { _ in
        return Response(status: .methodNotAllowed)
    }

    public func destroy(middleware: Middleware..., respond: RespondWithId) {
        let responder = BasicResponder { request in
            return try respond(request: request, id: request.id!)
        }
        self.destroy = middleware.chain(to: responder)
    }
}

public struct Resource {
    public let middleware: [Middleware]
    public let index: Responder
    public let create: Responder
    public let show: Responder
    public let update: Responder
    public let destroy: Responder

    public init(middleware: Middleware..., mediaTypes: [MediaType], build: (resource: ResourceBuilder) -> Void) {
        let builder = ResourceBuilder()
        build(resource: builder)
        let contentNegotiaton = ContentNegotiationMiddleware(mediaTypes: mediaTypes)
        self.middleware = [contentNegotiaton] + middleware
        self.index = builder.index
        self.create = builder.create
        self.show = builder.show
        self.update = builder.update
        self.destroy = builder.destroy
    }
}

extension RouterBuilder {
    public func resources(path: String, middleware: Middleware..., resources: Resource) {
        let middlewareChain =  middleware + resources.middleware
        addRoute(method: .get, path: path, middleware: middlewareChain, responder: resources.index)
        addRoute(method: .post, path: path, middleware: middlewareChain, responder: resources.create)
        addRoute(method: .get, path: path + "/:id", middleware: middlewareChain, responder: resources.show)
        addRoute(method: .put, path: path + "/:id", middleware: middlewareChain, responder: resources.update)
        addRoute(method: .patch, path: path + "/:id", middleware: middlewareChain, responder: resources.update)
        addRoute(method: .delete, path: path + "/:id", middleware: middlewareChain, responder: resources.destroy)
    }
}
