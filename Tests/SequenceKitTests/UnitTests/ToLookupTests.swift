//  ToLookupTests.swift
//  Created by Tornike on 05/04/2023.

import Foundation
import XCTest
@testable import SequenceKit

class ToLookupTests: XCTestCase {
  func testToLookup() {
    let words = ["apple", "banana", "car", "door", "elephant", "fox"]
    let expectedLookup: [String.Element: [String]] = [
      "a": ["apple"],
      "b": ["banana"],
      "c": ["car"],
      "d": ["door"],
      "e": ["elephant"],
      "f": ["fox"]
    ]

    let lookup = words.toLookup(keySelector: { $0.first ?? Character(" ") },
                                valueSelector: { $0 })

    XCTAssertEqual(lookup, expectedLookup)
  }
  
  func testEmptySequence() {
    let emptySequence = [String]()
    let expectedLookup = [String: [String]]()

    let lookup = emptySequence.toLookup(keySelector: { $0 },
                                        valueSelector: { $0 })

    XCTAssertEqual(lookup, expectedLookup)
  }

  func testDuplicates() {
    let numbers = [1, 2, 2, 3, 3, 3]
    let expectedLookup = [
      1: [1],
      2: [2, 2],
      3: [3, 3, 3]
    ]

    let lookup = numbers.toLookup(keySelector: { $0 },
                                  valueSelector: { $0 })
    XCTAssertEqual(lookup, expectedLookup)
  }

}
