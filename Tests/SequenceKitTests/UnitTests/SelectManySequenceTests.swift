//
//  SelectManySequenceTests.swift
//  
//
//  Created by Tornike on 03/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

struct NumberPair: Equatable {
  let first: Int
  let second: Int
}

class SelectManySequenceTests: XCTestCase {
  func testSimpleSelectMany() {
    let numbers = [1, 2, 3, 4]
    let simpleSelectManySequence = numbers.selectMany { number in
      AnySequence(1...number)
    }
    let expected = [1, 1, 2, 1, 2, 3, 1, 2, 3, 4]
    XCTAssertEqual(simpleSelectManySequence.toArray(), expected)
  }
  
  func testSelectManyWithIndex() {
    let numbers = [1, 2, 3, 4]
    let selectManySequence = numbers.selectMany({ number, index in
      AnySequence(index == 0 ? [] : Array(1...index))
    }, { number, pair in
      return NumberPair(first: number, second: pair)
    })
    let expectedResult: [NumberPair] = [
      NumberPair(first: 2, second: 1),
      NumberPair(first: 3, second: 1),
      NumberPair(first: 3, second: 2),
      NumberPair(first: 4, second: 1),
      NumberPair(first: 4, second: 2),
      NumberPair(first: 4, second: 3)
    ]
    let actualResult = Array(selectManySequence)
    print("Actual result: \(actualResult)")
    XCTAssertEqual(actualResult, expectedResult)
  }}
