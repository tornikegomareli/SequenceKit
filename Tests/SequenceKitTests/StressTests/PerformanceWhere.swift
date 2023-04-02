//
//  File.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class StressPerformanceTestsForWhere: XCTestCase {
  func testWherePerformance() {
    let million = 1000000
    let array = Array(0..<million)
    measure {
      _ = array.where { $0 % 2 == 0 }.toArray()
    }
  }
  
  func testNativeFilterPerformance() {
    let million = 1000000
    let array = Array(0..<million)
    measure {
      _ = array.filter { $0 % 2 == 0 }
    }
  }
}
