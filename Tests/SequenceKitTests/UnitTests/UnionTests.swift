//  UnionTests.swift
//  Created by Tornike on 05/04/2023.

import Foundation
import XCTest
@testable import SequenceKit

class UnionTests: XCTestCase {
  func testUnionWithArrays() {
    let first = [1, 2, 3]
    let second = [4, 5, 6]
    let union = first.union(second)
    let expectedResult = [1, 2, 3, 4, 5, 6]
    XCTAssertEqual(union.toArray(), expectedResult)
  }

  func testUnionWithEmptyArrays() {
    let first: [Int] = []
    let second: [Int] = []
    let union = first.union(second)
    XCTAssertTrue(union.toArray().isEmpty)
  }

  func testUnionWithDuplicateElements() {
    let first = [1, 2, 3, 3]
    let second = [2, 2, 4, 5]
    let union = first.union(second)
    let expectedResult = [1, 2, 3, 4, 5]
    XCTAssertEqual(union.toArray(), expectedResult)
  }

  func testUnionWithDifferentElementTypes() {
    let first = ["apple", "banana", "cherry"]
    let second = ["date", "elderberry", "fig"]
    let union = first.union(second)
    let expectedResult = ["apple", "banana", "cherry", "date", "elderberry", "fig"]
    XCTAssertEqual(union.toArray(), expectedResult)
  }
}
