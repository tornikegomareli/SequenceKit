//
//  JoinTests.swift
//  
//
//  Created by Tornike on 08/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class JoinTests: XCTestCase {
  private func sampleOuter() -> [Int] {
    return [5, 3, 7]
  }

  private func sampleInner() -> [String] {
    return ["bee", "giraffe", "tiger", "badger", "ox", "cat", "dog"]
  }

  private func yourLookupFunction<TInner, TKey: Hashable>(inner: [TInner], keySelector: (TInner) -> TKey) -> [TKey: [TInner]] {
    return Dictionary(grouping: inner, by: keySelector)
  }

  func testJoinEmptyOuter() {
    let outer: [Int] = []
    let inner = sampleInner()
    let joinSequence = join(
      outer: outer,
      inner: inner,
      outerKeySelector: { $0 % 2 },
      innerKeySelector: { $0.count % 2 },
      resultSelector: { "\($0) - \($1)" },
      lookup: yourLookupFunction
    )

    XCTAssertTrue(joinSequence.all(where: { _ in false }), "Join sequence should be empty")
  }

  func testJoinEmptyInner() {
    let outer = sampleOuter()
    let inner: [String] = []
    let joinSequence = join(
      outer: outer,
      inner: inner,
      outerKeySelector: { $0 % 2 },
      innerKeySelector: { $0.count % 2 },
      resultSelector: { "\($0) - \($1)" },
      lookup: yourLookupFunction
    )

    XCTAssertTrue(joinSequence.all(where: { _ in false }), "Join sequence should be empty")
  }

  func testJoinResults() {
    let outer = sampleOuter()
    let inner = sampleInner()
    let joinSequence = join(
      outer: outer,
      inner: inner,
      outerKeySelector: { $0 },
      innerKeySelector: { $0.count },
      resultSelector: { "\($0) - \($1)" },
      lookup: yourLookupFunction
    )

    let expectedResults = [
      "3 - bee",
      "3 - cat",
      "3 - dog",
      "5 - tiger",
      "7 - giraffe"
    ]

    let actualResultsSorted = joinSequence.toArray().sorted()
    let expectedResultsSorted = expectedResults.sorted()

    XCTAssertEqual(actualResultsSorted, expectedResultsSorted, "Join sequence should match the expected results")
  }

}
