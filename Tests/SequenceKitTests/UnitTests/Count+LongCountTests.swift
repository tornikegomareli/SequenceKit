//
//  File.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class CountLongCountTests: XCTestCase {
  func testCount() {
    let array = [1, 2, 3, 4, 5, 6]
    XCTAssertEqual(array.count, 6)
  }
  
  func testCountWithPredicate() {
    let array = [1, 2, 3, 4, 5, 6]
    let evenCount = array.count { $0 % 2 == 0 }
    XCTAssertEqual(evenCount, 3)
  }
  
  func testLongCount() {
    let array = [1, 2, 3, 4, 5, 6]
    let longResult = array.longCount{ $0 == $0 }
    XCTAssertEqual(longResult, 6)
    XCTAssertTrue(longResult is Int64)
  }
  
  func testLongCountWithPredicate() {
    let array = [1, 2, 3, 4, 5, 6]
    let oddLongCount = array.longCount { $0 % 2 != 0 }
    XCTAssertEqual(oddLongCount, 3)
    XCTAssertTrue(oddLongCount is Int64)
  }
}
