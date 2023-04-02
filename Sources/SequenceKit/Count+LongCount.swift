// Count+LongCount.swift
// Created by Tornike on 02/04/2023.

import Foundation

public extension Sequence {
  /// Returns the number of elements in the sequence.
  /// - Returns: The number of elements in the sequence.
  func count() -> Int {
    return reduce(0) { (count, _) in count + 1 }
  }
  
  /// Returns the number of elements in the sequence that satisfy the given predicate.
  /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element should be included in the count.
  /// - Returns: The number of elements in the sequence that satisfy the given predicate.
  func count(where predicate: (Element) -> Bool) -> Int {
    return reduce(0) { (count, element) in
      predicate(element) ? count + 1 : count
    }
  }
  
  /// Returns the number of elements in the sequence as a 64-bit integer.
  /// - Returns: The number of elements in the sequence as a 64-bit integer.
  func longCount() -> Int64 {
    return reduce(0) { (count, _) in count + 1 }
  }
  
  /// Returns the number of elements in the sequence that satisfy the given predicate as a 64-bit integer.
  /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element should be included in the count.
  /// - Returns: The number of elements in the sequence that satisfy the given predicate as a 64-bit integer.
  func longCount(where predicate: (Element) -> Bool) -> Int64 {
    return reduce(0) { (count, element) in
      predicate(element) ? count + 1 : count
    }
  }
}
