//
//  AnyAllTests.swift
//  
//
//  Created by Tornike on 04/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class AnyAllTests: XCTestCase {
  var numbers: [Int]!
  
  override func setUpWithError() throws {
    numbers = [1, 2, 3, 4, 5]
  }
  
  override func tearDownWithError() throws {
    numbers = nil
  }

  func testAny() {
    XCTAssertTrue(numbers.any(), "any() should return true when the sequence is not empty")
    
    let empty: [Int] = []
    XCTAssertFalse(empty.any(), "any() should return false when the sequence is empty")
  }
  
  func testAnyWithPredicate() {
    XCTAssertTrue(numbers.any(where: { $0 > 2 }), "any(where:) should return true when there is an element satisfying the predicate")
    XCTAssertFalse(numbers.any(where: { $0 > 5 }), "any(where:) should return false when no element satisfies the predicate")
  }
  
  func testAllWithPredicate() {
    XCTAssertTrue(numbers.all(where: { $0 > 0 }), "all(where:) should return true when all elements satisfy the predicate")
    XCTAssertFalse(numbers.all(where: { $0 > 2 }), "all(where:) should return false when at least one element doesn't satisfy the predicate")
  }
}
