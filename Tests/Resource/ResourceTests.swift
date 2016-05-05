import XCTest
@testable import Resource

public final class JSONMediaType: MediaType {
    public init() {
        super.init(
            type: "application",
            subtype: "json",
            parameters: ["charset": "utf-8"],
            parser: JSONStructuredDataParser(),
            serializer: JSONStructuredDataSerializer()
        )
    }
}

public struct JSONStructuredDataParser: StructuredDataParser {
    public func parse(_ data: Data) throws -> StructuredData {
        return ["title": "Zewo"]
    }
}

public struct JSONStructuredDataSerializer: StructuredDataSerializer {
    public func serialize(_ data: StructuredData) throws -> Data {
        return Data("{\"title\": \"Zewo\"}")
    }
}

struct Todo {
    let title: String
}

extension Todo: Mappable {
    init(mapper: Mapper) throws {
        self.title = try mapper.map(from: "title")
    }
}

extension Todo: StructuredDataRepresentable {
    var structuredData: StructuredData {
        return [
            "title": .make(title)
        ]
    }
}

class ResourceTests: XCTestCase {
    func testResource() {
        var called = 0
        let resource = Resource("/todos", mediaTypes: JSONMediaType()) { todo in
            todo.get { request in
                called = 1
                return Response()
            }

            todo.post { (request, todo: Todo) in
                called = 2
                XCTAssertEqual(todo.title, "Zewo")
                return Response(content: todo)
            }

            todo.get { (request, id: Int) in
                called = 3
                XCTAssertEqual(id, 42)
                return Response()
            }

            todo.put { (request, id: String, todo: Todo) in
                called = 4
                XCTAssertEqual(todo.title, "Zewo")
                XCTAssertEqual(id, "42")
                return Response(content: todo)
            }
            
            todo.delete { (request, id: String) in
                called = 5
                XCTAssertEqual(id, "42")
                return Response()
            }
        }

        var response: Response

        do {
            let headers: Headers = ["content-type": "application/json"]
            let body = "{\"title\": \"Zewo\"}"
            let todo: StructuredData = ["title": "Zewo"]

            let index = try Request(method: .get, uri: "/todos")
            response = try resource.respond(to: index)
            XCTAssertEqual(response.status, Status.ok)
            XCTAssertEqual(called, 1)

            let create = try Request(method: .post, uri: "/todos", headers: headers, body: body)
            response = try resource.respond(to: create)
            XCTAssertEqual(response.status, Status.ok)
            XCTAssertEqual(response.content, todo)
            XCTAssertEqual(called, 2)

            let view = try Request(method: .get, uri: "/todos/42")
            response = try resource.respond(to: view)
            XCTAssertEqual(response.status, Status.ok)
            XCTAssertEqual(called, 3)

            let update = try Request(method: .put, uri: "/todos/42", headers: headers, body: body)
            response = try resource.respond(to: update)
            XCTAssertEqual(response.status, Status.ok)
            XCTAssertEqual(response.content, todo)
            XCTAssertEqual(called, 4)

            let remove = try Request(method: .delete, uri: "/todos/42")
            response = try resource.respond(to: remove)
            XCTAssertEqual(response.status, Status.ok)
            XCTAssertEqual(called, 5)
        } catch {
            XCTFail("\(error)")
        }
    }
}

extension ResourceTests {
    static var allTests: [(String, ResourceTests -> () throws -> Void)] {
        return [
           ("testResource", testResource),
        ]
    }
}
