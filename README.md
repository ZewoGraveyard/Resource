# Resource

[![Zewo 0.4](https://img.shields.io/badge/Zewo-0.4-FF7565.svg?style=flat)](http://zewo.io)
[![Swift 3](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org)
[![Platform Linux](https://img.shields.io/badge/Platform-Linux-lightgray.svg?style=flat)](https://swift.org)
[![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://tldrlegal.com/license/mit-license)
[![Slack Status](https://zewo-slackin.herokuapp.com/badge.svg)](http://slack.zewo.io)

**Resource** provides RESTful resources for Zewo's [Router](https://github.com/Zewo/Router).

## Usage

```swift
public struct Todo {
    public let id: String?
    public let title: String
    public let done: Bool

    public init(id: String?, title: String, done: Bool) {
        self.id = id
        self.title = title
        self.done = done
    }
}

extension Todo: ContentMappable {
    public init(content: Content) throws {
        self.id = try? content.get("id")
        self.title = try content.get("title")
        self.done = try content.get("done")
    }
}

extension Todo: ContentRepresentable {
    public var content: Content {
        return [
            "id": Content.from(id),
            "title": Content.from(title),
            "done": Content.from(done)
        ]
    }
}

let router = Router { route in
    route.resources("/todos", resources: todoResources)
}

let todoResources = Resource(mediaTypes: [JSONMediaType()]) { todo in
    // GET /todos
    todo.index { request in
        let todos = try app.getAllTodos()
        return Response(content: ["todos": todos.content])
    }

	// POST /todos
    todo.create(content: Todo.self) { request, todo in
        let newTodo = try app.createTodo(title: todo.title, done: todo.done)
        return Response(content: newTodo)
    }

	// GET /todos/:id
    todo.show { request, id in
        let todo = try app.getTodo(id: id)
        return Response(content: todo)
    }

	// PUT /todos/:id
    todo.update(content: Todo.self) { request, id, todo in
        let newTodo = try app.updateTodo(id: id, title: todo.title, done: todo.done)
        return Response(content: newTodo)
    }

	// DELETE /todos/:id
    todo.destroy { request, id in
        try app.removeTodo(id: id)
        return Response(status: .noContent)
    }
}
```

## Installation

- Add `Resource` to your `Package.swift`

```swift
import PackageDescription

let package = Package(
	dependencies: [
		.Package(url: "https://github.com/Zewo/Resource.git", majorVersion: 0, minor: 4),
	]
)
```

## Community

[![Slack](http://s13.postimg.org/ybwy92ktf/Slack.png)](http://slack.zewo.io)

Join us on [Slack](http://slack.zewo.io).

License
-------

**Resource** is released under the MIT license. See LICENSE for details.
