//
//  File.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class EmptyTests: XCTestCase {
  func testEmptyContainsNoElements() {
    let empty = EmptySequence<Int>.instance
    let anyEmpty = AnySequence(empty)
    let result = anyEmpty.toArray()
    let s = [1,2,3,4]
    XCTAssertEqual(result.count, 0)
  }
}
