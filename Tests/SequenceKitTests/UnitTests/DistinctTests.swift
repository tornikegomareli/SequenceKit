//
//  File.swift
//  
//
//  Created by Tornike on 04/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class DistinctTests: XCTestCase {
  func testDistinct() {
    let numbers = [1, 2, 2, 3, 4, 4, 5, 5, 6]
    let distinctNumbers = Array(numbers.distinct())
    XCTAssertEqual(distinctNumbers, [1, 2, 3, 4, 5, 6])

    let strings = ["apple", "banana", "apple", "orange", "banana"]
    let distinctStrings = Array(strings.distinct())
    XCTAssertEqual(Set(distinctStrings), Set(["apple", "banana", "orange"]))

    let empty: [Int] = []
    let distinctEmpty = Array(empty.distinct())
    XCTAssertEqual(distinctEmpty, [])
  }
}
