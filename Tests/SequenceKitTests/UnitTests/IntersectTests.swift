//
//  IntersectTests.swift
//  
//
//  Created by Tornike on 05/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class IntersectTests: XCTestCase {
  func testIntersectWithMatchingElements() {
    let a = [1, 2, 3, 4, 5, 6]
    let b = [4, 5, 6, 7, 8, 9]
    let result = a.intersect(b)
    let expected = [4, 5, 6]
    XCTAssertEqual(result.toArray(), expected)
  }

  func testIntersectWithNoMatchingElements() {
    let a = [1, 2, 3]
    let b = [4, 5, 6]
    let result = a.intersect(b)
    let expected: [Int] = []
    XCTAssertEqual(result.toArray(), expected)
  }

  func testIntersectWithEmptySequence() {
    let a = [1, 2, 3]
    let b: [Int] = []
    let result = a.intersect(b)
    let expected: [Int] = []
    XCTAssertEqual(result.toArray(), expected)
  }
}
