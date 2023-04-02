//
//  RangeTests.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class RangeTests: XCTestCase {
  func testRangeWithValidInput() {
    let start = 5
    let count = 3
    let expectedResult = [5, 6, 7]
    
    do {
      let result = try range(start: start, count: count)
      XCTAssertEqual(Array(result), expectedResult)
    } catch {
      XCTFail("No error should be thrown for valid input")
    }
  }
  
  func testRangeWithInvalidCount() {
    let start = 5
    let count = -3
    
    XCTAssertThrowsError(try range(start: start, count: count)) { error in
      XCTAssertEqual(error as? RangeError, .invalidCount)
    }
  }
  
  func testRangeWithOutOfRangeCount() {
    let start = Int(Int32.max) - 1
    let count = 3
    
    XCTAssertThrowsError(try range(start: start, count: count)) { error in
      XCTAssertEqual(error as? RangeError, .countOutOfRange)
    }
  }
}
