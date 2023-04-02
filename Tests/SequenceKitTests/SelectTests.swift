//
//  File.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import XCTest
@testable import SequenceKit

class SelectTests: XCTestCase {
  func testSelectWithEmptySequence() {
    let numbers: [Int] = []
    let result = numbers.select { $0 * $0 }
    XCTAssertTrue(result.toArray().isEmpty)
  }

  func testSelectWithNonEmptySequence() {
    let numbers = [1, 2, 3, 4, 5]
    let squares = [1, 4, 9, 16, 25]
    let result = numbers.select { $0 * $0 }
    XCTAssertEqual(result.toArray(), squares)
  }

  func testSelectWithDifferentOutputType() {
    let numbers = [1, 2, 3, 4, 5]
    let strings = ["1", "2", "3", "4", "5"]
    let result = numbers.select { String($0) }
    XCTAssertEqual(result.toArray(), strings)
  }

  func testWhereAndSelectToChained() {
    let numbers = [1, 2, 3, 4, 5]
    let evenSquares = [4, 16]
    let result = numbers
      .where { $0 % 2 == 0 }
      .select { $0 * $0 }
    XCTAssertEqual(result.toArray(), evenSquares)
  }

  func testSelectLazyDeferredExecution() {
    let numbers = [1, 2, 3, 4, 5]
    
    var callCount = 0
    let squares = numbers.select {
      callCount += 1
      return $0 * $0
    }
    
    XCTAssertEqual(callCount, 0, "Transformation should not be called before iterating the sequence")
    
    var iterator = squares.makeIterator()
    let firstSquare = iterator.next()
    
    XCTAssertEqual(firstSquare, 1, "First square should be 1")
    XCTAssertEqual(callCount, 1, "Transformation should be called only once to find the first square")
  }
}
