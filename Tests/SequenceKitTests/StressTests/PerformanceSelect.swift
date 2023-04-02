//
//  File.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class StressPerformanceTestsForSelect: XCTestCase {
  func testSelectPerformance() {
    let array = Array(0..<1000000)
    measure {
      _ = array.select { $0 * 2 }.toArray()
    }
  }
  
  func testNativeMapPerformance() {
    let array = Array(0..<1000000)
    measure {
      _ = array.map { $0 * 2 }
    }
  }
}
