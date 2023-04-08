//
//  File.swift
//  
//
//  Created by Tornike on 09/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class ToDictionaryTests: XCTestCase {
  struct Person {
    let name: String
    let age: Int
  }

  func testToDictionary() throws {
    let people = [
      Person(name: "Alice", age: 30),
      Person(name: "Bob", age: 25),
      Person(name: "Charlie", age: 35),
      Person(name: "David", age: 40)
    ]

    let dictionary = people.toDictionary(withKeys: { $0.name },
                                             andValues: { $0.age })

    XCTAssertEqual(dictionary.count, 4)
    XCTAssertEqual(dictionary["Alice"], 30)
    XCTAssertEqual(dictionary["Bob"], 25)
    XCTAssertEqual(dictionary["Charlie"], 35)
    XCTAssertEqual(dictionary["David"], 40)
  }
}
