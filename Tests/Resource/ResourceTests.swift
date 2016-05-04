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
            "id": id.map({StructuredData($0)}) ?? nil,
            "title": StructuredData(title),
            "done": StructuredData(done)
        ]
    }
}

class ResourceTests: XCTestCase {
    func testReality() {
        let logger: Middleware

        let todoResource = Resource("/todos") { todo in
            todo.get { request in
                return Response()
            }

            todo.post { (request, todo: Todo) in
                return Response()
            }

            todo.get { (request, id: Int) in
                return Response()
            }

            todo.put { (request, id: String, todo: Todo) in
                return Response()
            }
            
            todo.delete { (request, id: String) in
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
