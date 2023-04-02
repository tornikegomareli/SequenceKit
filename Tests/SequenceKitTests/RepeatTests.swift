//
//  File.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class RepeateTests: XCTestCase {
  func testRepeatElementWithCountZero() {
    let repeated = repeatElement(42, count: 0)
    XCTAssertEqual(repeated.toArray(), [])
  }
  
  func testRepeatElementWithPositiveCount() {
    let repeated = repeatElement(42, count: 3)
    XCTAssertEqual(repeated.toArray(), [42, 42, 42])
  }
  
  func testRepeatElementIsLazy() {
    var callCount = 0
    let repeated = repeatElement(42, count: 3)
      .select { (value: Int) -> Int in
        callCount += 1
        return value * 2
      }
    XCTAssertEqual(callCount, 0, "Mapping should not be called before iterating the sequence")
    XCTAssertEqual(repeated.toArray(), [84, 84, 84])
    XCTAssertEqual(callCount, 3, "Mapping should be called exactly once for each element")
  }
}
