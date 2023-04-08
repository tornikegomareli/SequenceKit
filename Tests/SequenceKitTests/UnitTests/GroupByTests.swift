//
//  GroupByTests.swift
//  
//
//  Created by Tornike on 08/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit
import XCTest

struct Person {
  let name: String
  let age: Int
}

class GroupByTests: XCTestCase {
  var people: [Person] = []

  override func setUp() {
    super.setUp()

    people = [
      Person(name: "Alice", age: 25),
      Person(name: "Bob", age: 25),
      Person(name: "Charlie", age: 30),
      Person(name: "David", age: 30)
    ]
  }

  func testGroupByDeferred() {
    let groupedSequence = people.groupBy { $0.age }
    var groupedByAge: [Int: [Person]] = [:]

    for (key, group) in groupedSequence {
      groupedByAge[key] = group
    }

    XCTAssertEqual(groupedByAge.keys.count, 2)
    XCTAssertEqual(groupedByAge[25]?.count, 2)
    XCTAssertEqual(groupedByAge[30]?.count, 2)

    let namesForAge25 = groupedByAge[25]?.map { $0.name } ?? []
    XCTAssertTrue(namesForAge25.contains("Alice"))
    XCTAssertTrue(namesForAge25.contains("Bob"))

    let namesForAge30 = groupedByAge[30]?.map { $0.name } ?? []
    XCTAssertTrue(namesForAge30.contains("Charlie"))
    XCTAssertTrue(namesForAge30.contains("David"))
  }

  func testGroupByDeferredWithTransform() {
    let groupedSequence = people.groupBy({ $0.age }, { $0.name })
    var groupedByAgeWithNames: [Int: [String]] = [:]

    for (key, group) in groupedSequence {
      groupedByAgeWithNames[key] = group
    }

    XCTAssertEqual(groupedByAgeWithNames.keys.count, 2)
    XCTAssertEqual(groupedByAgeWithNames[25]?.count, 2)
    XCTAssertEqual(groupedByAgeWithNames[30]?.count, 2)

    XCTAssertTrue(groupedByAgeWithNames[25]?.contains("Alice") ?? false)
    XCTAssertTrue(groupedByAgeWithNames[25]?.contains("Bob") ?? false)
    XCTAssertTrue(groupedByAgeWithNames[30]?.contains("Charlie") ?? false)
    XCTAssertTrue(groupedByAgeWithNames[30]?.contains("David") ?? false)
  }
}
