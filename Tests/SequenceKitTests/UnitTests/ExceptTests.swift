//  ExceptTests.swift
//  Created by Tornike on 05/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class ExceptTests: XCTestCase {
  func testExcept() {
    let first = [1, 2, 3, 4, 5]
    let second = [4, 5, 6, 7, 8]
    let exceptSequence = Array(first.except(second))
    XCTAssertEqual(exceptSequence, [1, 2, 3])

    let strings1 = ["apple", "banana", "orange"]
    let strings2 = ["banana", "orange", "grape"]
    let exceptStrings = Array(strings1.except(strings2))
    XCTAssertEqual(Set(exceptStrings), Set(["apple"]))

    let empty: [Int] = []
    let exceptEmpty = empty.except(first).toArray()
    XCTAssertEqual(exceptEmpty, [])
  }
}
