//
//  Range.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

public enum RangeError: Error {
  case invalidCount
  case countOutOfRange
}

public struct IntRangeSequence: Sequence, IteratorProtocol {
  private let start: Int
  private let count: Int
  private var currentIndex: Int
  
  public init(start: Int, count: Int) {
    self.start = start
    self.count = count
    self.currentIndex = 0
  }
  
  public mutating func next() -> Int? {
    guard currentIndex < count else { return nil }
    let nextValue = start + currentIndex
    currentIndex += 1
    return nextValue
  }
}

public func range(start: Int, count: Int) throws -> IntRangeSequence {
  if count < 0 {
    throw RangeError.invalidCount
  }
  if Int64(start) + Int64(count) - 1 > Int64(Int32.max) {
    throw RangeError.countOutOfRange
  }
  return IntRangeSequence(start: start, count: count)
}
