// Range.swift
// Created by Tornike on 02/04/2023.

import Foundation

/// An enum representing errors that can occur when creating an integer range.
public enum RangeError: Error {
  /// The count of the range is invalid.
  case invalidCount
  /// The count of the range is out of range.
  case countOutOfRange
}

/// A struct representing a range of integers from a given starting point and count.
public struct IntRangeSequence: Sequence, IteratorProtocol {
  /// The starting point of the range.
  private let start: Int
  /// The count of integers in the range.
  private let count: Int
  /// The current index in the range.
  private var currentIndex: Int
  
  /// Initializes an `IntRangeSequence` instance with the given starting point and count.
  /// - Parameters:
  ///   - start: The starting point of the range.
  ///   - count: The count of integers in the range.
  public init(start: Int, count: Int) {
    self.start = start
    self.count = count
    self.currentIndex = 0
  }
  
  /// Provides the next integer in the range.
  /// - Returns: The next integer in the range, or nil if the end of the range is reached.
  public mutating func next() -> Int? {
    guard currentIndex < count else { return nil }
    let nextValue = start + currentIndex
    currentIndex += 1
    return nextValue
  }
}

/// Creates an integer range with the given starting point and count.
/// - Parameters:
///   - start: The starting point of the range.
///   - count: The count of integers in the range.
/// - Throws: A `RangeError` if the count is negative or if the resulting range would exceed the maximum representable integer.
/// - Returns: An `IntRangeSequence` instance representing the integer range.
public func range(start: Int, count: Int) throws -> IntRangeSequence {
  if count < 0 {
    throw RangeError.invalidCount
  }
  if Int64(start) + Int64(count) - 1 > Int64(Int32.max) {
    throw RangeError.countOutOfRange
  }
  return IntRangeSequence(start: start, count: count)
}
