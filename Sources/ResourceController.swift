// ResourceController.swift
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

public protocol ResourceController {
    associatedtype DetailID: PathParameterInitializable = UpdateID
    associatedtype UpdateID: PathParameterInitializable
    associatedtype DestroyID: PathParameterInitializable = UpdateID

    associatedtype CreateInput: StructuredDataInitializable = UpdateInput
    associatedtype UpdateInput: StructuredDataInitializable

    associatedtype ListOutput: StructuredDataFallibleRepresentable = UpdateOutput
    associatedtype CreateOutput: StructuredDataFallibleRepresentable = UpdateOutput
    associatedtype DetailOutput: StructuredDataFallibleRepresentable = UpdateOutput
    associatedtype UpdateOutput: StructuredDataFallibleRepresentable

    func list() throws -> [ListOutput]
    func create(element: CreateInput) throws -> CreateOutput
    func detail(id: DetailID) throws -> DetailOutput
    func update(id: UpdateID, element: UpdateInput) throws -> UpdateOutput
    func destroy(id: DestroyID) throws
}

extension ResourceController {
    public func list() throws -> [ListOutput] {
        throw ClientError.notFound
    }

    public func create(element: CreateInput) throws -> CreateOutput {
        throw ClientError.notFound
    }

    public func detail(id: DetailID) throws -> DetailOutput {
        throw ClientError.notFound
    }

    public func update(id: UpdateID, element: UpdateInput) throws -> UpdateOutput {
        throw ClientError.notFound
    }

    public func destroy(id: DestroyID) throws {
        throw ClientError.notFound
    }
}
