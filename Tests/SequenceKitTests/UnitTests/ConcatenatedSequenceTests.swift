//
//  File.swift
//  
//
//  Created by Tornike on 03/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit


class ConcatenatedSequenceTests: XCTestCase {
  func testEmptySequences() {
    let firstSequence: [Int] = []
    let secondSequence: [Int] = []
    
    let concatenatedSequence = firstSequence.concat(secondSequence)
    
    XCTAssertTrue(concatenatedSequence.toArray().isEmpty)
  }
  
  func testFirstSequenceEmpty() {
    let firstSequence: [Int] = []
    let secondSequence = [4, 5, 6]
    
    let concatenatedSequence = firstSequence.concat(secondSequence)
    
    XCTAssertEqual(Array(concatenatedSequence), secondSequence)
  }
  
  func testSecondSequenceEmpty() {
    let firstSequence = [1, 2, 3]
    let secondSequence: [Int] = []
    
    let concatenatedSequence = firstSequence.concat(secondSequence)
    
    XCTAssertEqual(Array(concatenatedSequence), firstSequence)
  }
  
  func testNonEmptySequences() {
    let firstSequence = [1, 2, 3]
    let secondSequence = [4, 5, 6]
    
    let concatenatedSequence = firstSequence.concat(secondSequence)
    
    XCTAssertEqual(Array(concatenatedSequence), [1, 2, 3, 4, 5, 6])
  }
}
