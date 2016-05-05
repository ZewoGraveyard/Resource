// ResourceBuilder.swift
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

public final class ResourceBuilder: RouterBuilder {}

extension ResourceBuilder {
    public func get(middleware: Middleware..., respond: Request throws -> Response) {
        addRoute(method: .get, middleware: middleware, respond: respond)
    }

    public func get<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        addRoute(method: .get, middleware: middleware, id: id, respond: respond)
    }
}

extension ResourceBuilder {
    public func head(middleware: Middleware..., respond: Respond) {
        addRoute(method: .head, middleware: middleware, respond: respond)
    }

    public func head<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        addRoute(method: .head, middleware: middleware, id: id, respond: respond)
    }
}

extension ResourceBuilder {
    public func post(middleware: Middleware..., respond: Respond) {
        addRoute(method: .post, middleware: middleware, respond: respond)
    }

    public func post(middleware: Middleware..., content: StructuredData.Type, respond: (request: Request, content: StructuredData) throws -> Response) {
        addRoute(method: .post, middleware: middleware, respond: respond)
    }

    public func post<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, content: T) throws -> Response) {
        addRoute(method: .post, middleware: middleware, content: content, respond: respond)
    }

    public func post<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        addRoute(method: .post, middleware: middleware, id: id, respond: respond)
    }

    public func post<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I, content: StructuredData) throws -> Response) {
        addRoute(method: .post, middleware: middleware, id: id, respond: respond)
    }

    public func post<I: ResourceIdentifier, T: ContentMappable>(middleware: Middleware..., id: I.Type = I.self, content: T.Type = T.self, respond: (request: Request, id: I, content: T) throws -> Response) {
        addRoute(method: .post, middleware: middleware, id: id, content: content, respond: respond)
    }
}

extension ResourceBuilder {
    public func put(middleware: Middleware..., respond: Respond) {
        addRoute(method: .put, middleware: middleware, respond: respond)
    }

    public func put(middleware: Middleware..., content: StructuredData.Type, respond: (request: Request, content: StructuredData) throws -> Response) {
        addRoute(method: .put, middleware: middleware, respond: respond)
    }

    public func put<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, content: T) throws -> Response) {
        addRoute(method: .put, middleware: middleware, content: content, respond: respond)
    }

    public func put<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        addRoute(method: .put, middleware: middleware, id: id, respond: respond)
    }

    public func put<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I, content: StructuredData) throws -> Response) {
        addRoute(method: .put, middleware: middleware, id: id, respond: respond)
    }

    public func put<I: ResourceIdentifier, T: ContentMappable>(middleware: Middleware..., id: I.Type = I.self, content: T.Type = T.self, respond: (request: Request, id: I, content: T) throws -> Response) {
        addRoute(method: .put, middleware: middleware, id: id, content: content, respond: respond)
    }
}

extension ResourceBuilder {
    public func patch(middleware: Middleware..., respond: Respond) {
        addRoute(method: .patch, middleware: middleware, respond: respond)
    }

    public func patch(middleware: Middleware..., content: StructuredData.Type, respond: (request: Request, content: StructuredData) throws -> Response) {
        addRoute(method: .patch, middleware: middleware, respond: respond)
    }

    public func patch<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, content: T) throws -> Response) {
        addRoute(method: .patch, middleware: middleware, content: content, respond: respond)
    }

    public func patch<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        addRoute(method: .patch, middleware: middleware, id: id, respond: respond)
    }

    public func patch<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I, content: StructuredData) throws -> Response) {
        addRoute(method: .patch, middleware: middleware, id: id, respond: respond)
    }

    public func patch<I: ResourceIdentifier, T: ContentMappable>(middleware: Middleware..., id: I.Type = I.self, content: T.Type = T.self, respond: (request: Request, id: I, content: T) throws -> Response) {
        addRoute(method: .patch, middleware: middleware, id: id, content: content, respond: respond)
    }
}

extension ResourceBuilder {
    public func delete(middleware: Middleware..., respond: Respond) {
        addRoute(method: .delete, middleware: middleware, respond: respond)
    }

    public func delete(middleware: Middleware..., content: StructuredData.Type, respond: (request: Request, content: StructuredData) throws -> Response) {
        addRoute(method: .delete, middleware: middleware, respond: respond)
    }

    public func delete<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, content: T) throws -> Response) {
        addRoute(method: .delete, middleware: middleware, content: content, respond: respond)
    }

    public func delete<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        addRoute(method: .delete, middleware: middleware, id: id, respond: respond)
    }

    public func delete<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I, content: StructuredData) throws -> Response) {
        addRoute(method: .delete, middleware: middleware, id: id, respond: respond)
    }

    public func delete<I: ResourceIdentifier, T: ContentMappable>(middleware: Middleware..., id: I.Type = I.self, content: T.Type = T.self, respond: (request: Request, id: I, content: T) throws -> Response) {
        addRoute(method: .delete, middleware: middleware, id: id, content: content, respond: respond)
    }
}

extension ResourceBuilder {
    public func options(middleware: Middleware..., respond: Respond) {
        addRoute(method: .options, middleware: middleware, respond: respond)
    }

    public func options(middleware: Middleware..., content: StructuredData.Type, respond: (request: Request, content: StructuredData) throws -> Response) {
        addRoute(method: .options, middleware: middleware, respond: respond)
    }

    public func options<T: ContentMappable>(middleware: Middleware..., content: T.Type = T.self, respond: (request: Request, content: T) throws -> Response) {
        addRoute(method: .options, middleware: middleware, content: content, respond: respond)
    }

    public func options<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        addRoute(method: .options, middleware: middleware, id: id, respond: respond)
    }

    public func options<I: ResourceIdentifier>(middleware: Middleware..., id: I.Type = I.self, respond: (request: Request, id: I, content: StructuredData) throws -> Response) {
        addRoute(method: .options, middleware: middleware, id: id, respond: respond)
    }

    public func options<I: ResourceIdentifier, T: ContentMappable>(middleware: Middleware..., id: I.Type = I.self, content: T.Type = T.self, respond: (request: Request, id: I, content: T) throws -> Response) {
        addRoute(method: .options, middleware: middleware, id: id, content: content, respond: respond)
    }
}

extension ResourceBuilder {
    public func addRoute(method: Method, middleware: [Middleware], respond: Respond) {
        addRoute(method: method, path: "", middleware: middleware, responder: BasicResponder(respond))
    }

    public func addRoute(method: Method, middleware: [Middleware], respond: (request: Request, content: StructuredData) throws -> Response) {
        let responder = BasicResponder { request in
            guard let content = request.content else {
                throw ClientError.badRequest
            }
            return try respond(request: request, content: content)
        }
        addRoute(method: method, path: "", middleware: middleware, responder: responder)
    }

    public func addRoute<T: ContentMappable>(method: Method, middleware: [Middleware], content: T.Type = T.self, respond: (request: Request, content: T) throws -> Response) {
        let contentMapper = ContentMapperMiddleware(mappingTo: content)
        let responder = BasicResponder { request in
            guard let content = request.storage[T.key] as? T else {
                throw ClientError.badRequest
            }
            return try respond(request: request, content: content)
        }
        addRoute(method: method, path: "", middleware: [contentMapper] + middleware, responder: responder)
    }

    public func addRoute<I: ResourceIdentifier>(method: Method, middleware: [Middleware], id: I.Type = I.self, respond: (request: Request, id: I) throws -> Response) {
        let responder = BasicResponder { request in
            let id = try id.init(resourceIdentifier: request.pathParameters["id"]!)
            return try respond(request: request, id: id)
        }
        addRoute(method: method, path: "/:id", middleware: middleware, responder: responder)
    }

    public func addRoute<I: ResourceIdentifier>(method: Method, middleware: [Middleware], id: I.Type = I.self, respond: (request: Request, id: I, content: StructuredData) throws -> Response) {
        let responder = BasicResponder { request in
            let id = try id.init(resourceIdentifier: request.pathParameters["id"]!)
            guard let content = request.content else {
                throw ClientError.badRequest
            }
            return try respond(request: request, id: id, content: content)
        }
        addRoute(method: method, path: "/:id", middleware: middleware, responder: responder)
    }
    
    public func addRoute<I: ResourceIdentifier, T: ContentMappable>(method: Method, middleware: [Middleware], id: I.Type = I.self, content: T.Type = T.self, respond: (request: Request, id: I, content: T) throws -> Response) {
        let contentMapper = ContentMapperMiddleware(mappingTo: content)
        let responder = BasicResponder { request in
            let id = try id.init(resourceIdentifier: request.pathParameters["id"]!)
            guard let content = request.storage[T.key] as? T else {
                throw ClientError.badRequest
            }
            return try respond(request: request, id: id, content: content)
        }
        addRoute(method: method, path: "/:id", middleware: [contentMapper] + middleware, responder: responder)
    }
}
