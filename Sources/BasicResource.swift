// BasicResource.swift
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
@_exported import RecoveryMiddleware
@_exported import JSONMediaType
@_exported import URLEncodedFormMediaType
@_exported import Sideburns

public struct BasicResource: RouterProtocol {
    public let middleware: [Middleware]
    public let routes: [Route]
    public let fallback: Responder
    public let matcher: RouteMatcher

    init(
        matcher: RouteMatcher.Type,
        middleware: [Middleware],
        mediaTypes: [MediaTypeRepresentor.Type],
        resource: ResourceBuilder) {
        var chain: [Middleware] = []

        if let recover = resource.recover {
            chain.append(RecoveryMiddleware(recover))
        }

        var types: [MediaTypeRepresentor.Type] = [JSON.self, URLEncodedForm.self]
        types.append(contentsOf: mediaTypes)
        let contentNegotiaton = ContentNegotiationMiddleware(mediaTypes: types)
        chain.append(contentNegotiaton)

        chain.append(contentsOf: middleware)

        self.middleware = chain
        self.fallback = resource.fallback
        self.matcher = matcher.init(routes: resource.routes)
        self.routes = resource.routes
    }

    public init(
        path: String = "",
        matcher: RouteMatcher.Type = TrieRouteMatcher.self,
        mediaTypes: [MediaTypeRepresentor.Type] = [],
        middleware: [Middleware] = [],
        build: @noescape (resource: ResourceBuilder) -> Void
        ) {
        let resource = ResourceBuilder(path: path)
        build(resource: resource)
        self.init(
            matcher: matcher,
            middleware: middleware,
            mediaTypes: mediaTypes,
            resource: resource
        )
    }

    public func match(_ request: Request) -> Route? {
        return matcher.match(request)
    }
}

extension BasicResource {
    public func respond(to request: Request) throws -> Response {
        let responder = match(request) ?? fallback
        return try middleware.chain(to: responder).respond(to: request)
    }
}
