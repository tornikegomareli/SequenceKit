// Repeat.swift
// Created by Tornike on 02/04/2023.

import Foundation

/// Returns a sequence that contains the specified element repeated the specified number of times.
///
/// - Parameters:
///   - element: The element to repeat.
///   - count: The number of times the element should be repeated.
/// - Returns: A sequence containing `count` repetitions of the `element`.
public func repeatElement<T>(_ element: T, count: Int) -> RepeatSequence<T> {
  return RepeatSequence(sequence: element, count: count)
}

/// A sequence that contains the specified element repeated the specified number of times.
public struct RepeatSequence<SequenceType: Sequence>: Sequence {
  let sequence: SequenceType
  let count: Int
  
  /// Initializes a new instance of the `RepeatSequence` structure.
  ///
  /// - Parameters:
  ///   - sequence: The element to repeat.
  ///   - count: The number of times the element should be repeated.
  public init(sequence: SequenceType, count: Int) {
    self.sequence = sequence
    self.count = count
  }
  
  /// Returns an iterator over the elements of this sequence.
  ///
  /// - Returns: An iterator over the elements of this sequence.
  public func makeIterator() -> RepeatIterator<SequenceType.Iterator> {
    return RepeatIterator(element: sequence.makeIterator(), count: count)
  }
}

/// An iterator that returns the specified element repeated the specified number of times.
public struct RepeatIterator<T>: IteratorProtocol {
  let element: T
  var count: Int
  
  /// Initializes a new instance of the `RepeatIterator` structure.
  ///
  /// - Parameters:
  ///   - element: The element to repeat.
  ///   - count: The number of times the element should be repeated.
  init(element: T, count: Int) {
    self.element = element
    self.count = count
  }
  
  /// Advances to the next element and returns it, or `nil` if no next element exists.
  ///
  /// - Returns: The next element in the sequence, or `nil` if the sequence has ended.
  public mutating func next() -> T? {
    guard count > 0 else { return nil }
    count -= 1
    return element
  }
}
