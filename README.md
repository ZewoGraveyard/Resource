# Resource

[![Swift][swift-badge]][swift-url]
[![Zewo][zewo-badge]][zewo-url]
[![Platform][platform-badge]][platform-url]
[![License][mit-badge]][mit-url]
[![Slack][slack-badge]][slack-url]
[![Travis][travis-badge]][travis-url]
[![Codebeat][codebeat-badge]][codebeat-url]

**Resource** provides RESTful resources for Zewo's [Router](https://github.com/Zewo/Router).

## Usage

```swift
import Zewo

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
    public init(mapper: Mapper) throws {
        self.id = mapper.map(optionalFrom: "id")
        self.title = try mapper.map(from: "title")
        self.done = try mapper.map(from: "done")
    }
}

extension Todo: StructuredDataRepresentable {
    public var structuredData: StructuredData {
        return [
            "id": id.map({StructuredData.from($0)}) ?? nil,
            "title": StructuredData.from(title),
            "done": StructuredData.from(done)
        ]
    }
}

let todoResources = Resource(mediaTypes: [JSONMediaType(), URLEncodedFormMediaType()]) { todo in
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

let app = Router { route in
    route.resources("/todos", resources: todoResources)
}

try Server(app).start()
```

## Installation

- Add `Resource` to your `Package.swift`

```swift
import PackageDescription

let package = Package(
	dependencies: [
		.Package(url: "https://github.com/Zewo/Resource.git", majorVersion: 0, minor: 5),
	]
)
```

## Support

If you need any help you can join our [Slack](http://slack.zewo.io) and go to the **#help** channel. Or you can create a Github [issue](https://github.com/Zewo/Zewo/issues/new) in our main repository. When stating your issue be sure to add enough details, specify what module is causing the problem and reproduction steps.

## Community

[![Slack][slack-image]][slack-url]

The entire Zewo code base is licensed under MIT. By contributing to Zewo you are contributing to an open and engaged community of brilliant Swift programmers. Join us on [Slack](http://slack.zewo.io) to get to know us!

## License

This project is released under the MIT license. See [LICENSE](LICENSE) for details.

[swift-badge]: https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat
[swift-url]: https://swift.org
[zewo-badge]: https://img.shields.io/badge/Zewo-0.5-FF7565.svg?style=flat
[zewo-url]: http://zewo.io
[platform-badge]: https://img.shields.io/badge/Platforms-OS%20X%20--%20Linux-lightgray.svg?style=flat
[platform-url]: https://swift.org
[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license
[slack-image]: http://s13.postimg.org/ybwy92ktf/Slack.png
[slack-badge]: https://zewo-slackin.herokuapp.com/badge.svg
[slack-url]: http://slack.zewo.io
[travis-badge]: https://travis-ci.org/Zewo/Resource.svg?branch=master
[travis-url]: https://travis-ci.org/Zewo/Resource
[codebeat-badge]: https://codebeat.co/badges/366388bf-7a17-4e09-8918-aef116d8eef0
[codebeat-url]: https://codebeat.co/projects/github-com-zewo-resource
