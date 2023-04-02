//
//  WhereTests.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import XCTest
@testable import SequenceKit

final class WhereTests: XCTestCase {
  func testWhereWithEmptyArray() {
    let emptyArray: [Int] = []
    let result = emptyArray.where { $0 % 2 == 0 }
    XCTAssertTrue(result.toArray().isEmpty)
  }
  
  func testWhereWithAllMatchingElements() {
    let numbers = [2, 4, 6, 8, 10]
    let result = numbers.where { $0 % 2 == 0 }
    XCTAssertEqual(result.toArray(), numbers)
  }
  
  func testWhereWithSomeMatchingElements() {
    let numbers = [1, 2, 3, 4, 5]
    let result = numbers.where { $0 % 2 == 0 }
    XCTAssertEqual(result.toArray(), [2, 4])
  }

  func testWhereWithNoMatchingElements() {
    let numbers = [1, 3, 5, 7, 9]
    let result = numbers.where { $0 % 2 == 0 }
    XCTAssertTrue(result.toArray().isEmpty)
  }

  func testWhereWithDifferentElementTypes() {
    let words = ["apple", "banana", "cherry"]
    let result = words.where { $0.count > 5 }
    XCTAssertEqual(result.toArray(), ["banana", "cherry"])
  }
  
  func testWhereLazyDeferredExecution() {
    let numbers = [1, 2, 3, 4, 5]
    
    var callCount = 0
    let evenNumbers = numbers.where {
      callCount += 1
      return $0 % 2 == 0
    }
    
    XCTAssertEqual(callCount, 0, "Predicate should not be called before iterating the sequence")
    
    var iterator = evenNumbers.makeIterator()
    let firstEvenNumber = iterator.next()
    
    XCTAssertEqual(firstEvenNumber, 2, "First even number should be 2")
    XCTAssertEqual(callCount, 2, "Predicate should be called only twice to find the first even number")
  }
}
