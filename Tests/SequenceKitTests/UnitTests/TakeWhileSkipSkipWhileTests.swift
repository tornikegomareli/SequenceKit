//
//  TakeWhileSkipSkipWhileTests.swift
//  
//
//  Created by Tornike on 09/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class TakeWhileSkipSkipWhileTests: XCTestCase {
  func testTake() {
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    let firstFive = numbers.take(5).toArray()
    XCTAssertEqual(firstFive, [1, 2, 3, 4, 5])

    let emptyTake = numbers.take(0).toArray()
    XCTAssertEqual(emptyTake, [])

    let takeMoreThanCount = numbers.take(20).toArray()
    XCTAssertEqual(takeMoreThanCount, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  }

  func testTakeWhile() {
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    let oddNumbers = numbers.takeWhile { $0 % 2 != 0 }.toArray()
    XCTAssertEqual(oddNumbers, [1])

    let lessThanFive = numbers.takeWhile { $0 < 5 }.toArray()
    XCTAssertEqual(lessThanFive, [1, 2, 3, 4])

    let takeWhileFalse = numbers.takeWhile { $0 > 20 }.toArray()
    XCTAssertEqual(takeWhileFalse, [])
  }

  func testSkip() {
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    let lastFive = numbers.skip(5).toArray()
    XCTAssertEqual(lastFive, [6, 7, 8, 9, 10])

    let skipMoreThanCount = numbers.skip(20).toArray()
    XCTAssertEqual(skipMoreThanCount, [])

    let emptySkip = numbers.skip(0).toArray()
    XCTAssertEqual(emptySkip, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  }

  func testSkipWhile() {
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    let evenNumbersAfterFive = numbers.skipWhile { $0 < 5 }.toArray()
    XCTAssertEqual(evenNumbersAfterFive, [5, 6, 7, 8, 9, 10])

    let skipWhileFalse = numbers.skipWhile { $0 > 20 }.toArray()
    XCTAssertEqual(skipWhileFalse, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

    let skipWhileTrue = numbers.skipWhile { $0 < 20 }.toArray()
    XCTAssertEqual(skipWhileTrue, [])
  }
}
