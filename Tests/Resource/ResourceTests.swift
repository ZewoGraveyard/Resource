import XCTest
@testable import Resource

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

class ResourceTests: XCTestCase {
    func testReality() {
        let todoResources = Resource(mediaTypes: []) { todo in
            // GET /todos
            todo.index { request in
//                let todos = try app.getAllTodos()
//                return Response(content: ["todos": todos.content])
                return Response()
            }

            // POST /todos
            todo.create(content: Todo.self) { request, todo in
//                let newTodo = try app.createTodo(title: todo.title, done: todo.done)
//                return Response(content: newTodo)
                return Response()
            }

            // GET /todos/:id
            todo.show { request, id in
//                let todo = try app.getTodo(id: id)
//                return Response(content: todo)
                return Response()
            }
            
            // PUT /todos/:id
            todo.update(content: Todo.self) { request, id, todo in
//                let newTodo = try app.updateTodo(id: id, title: todo.title, done: todo.done)
//                return Response(content: newTodo)
                return Response()
            }
            
            // DELETE /todos/:id
            todo.destroy { request, id in
//                try app.removeTodo(id: id)
//                return Response(status: .noContent)
                return Response()
            }
        }
    }
}

extension ResourceTests {
    static var allTests: [(String, ResourceTests -> () throws -> Void)] {
        return [
           ("testReality", testReality),
        ]
    }
}
