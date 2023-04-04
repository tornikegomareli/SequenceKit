//  Any+All.swift
//  Created by Tornike on 04/04/2023.
//

import Foundation

/// This file defines extensions to the `Sequence` protocol for checking if any or all elements in a sequence satisfy a given predicate.
/// It also contains the implementation of the `CustomAnySequence` struct which is a custom sequence type that allows for lazy evaluation of `any()` and `all()` operations.
public extension Sequence {

  /// Returns `true` if the sequence is not empty.
  ///
  /// - Returns: `true` if the sequence is not empty.
  func any() -> Bool {
    return CustomAnySequence(self).makeIterator().next() != nil
  }

  /// Returns `true` if any element in the sequence satisfies the given predicate, `false` otherwise.
  ///
  /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element satisfies a condition.
  /// - Returns: `true` if any element in the sequence satisfies the given predicate, `false` otherwise.
  func any(where predicate: (Element) -> Bool) -> Bool {
    let customSequence = CustomAnySequence(self)
    for element in customSequence {
      if predicate(element) {
        return true
      }
    }
    return false
  }

  /// Returns `true` if all elements in the sequence satisfy the given predicate, `false` otherwise.
  ///
  /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element satisfies a condition.
  /// - Returns: `true` if all elements in the sequence satisfy the given predicate, `false` otherwise.
  func all(where predicate: (Element) -> Bool) -> Bool {
    let customSequence = CustomAnySequence(self)
    for element in customSequence {
      if !predicate(element) {
        return false
      }
    }
    return true
  }
}

/// A custom sequence type that allows for lazy evaluation of `any()` and `all()` operations.
public struct CustomAnySequence<Element>: Sequence {

  private let _makeIterator: () -> AnyIterator<Element>

  /// Creates a new instance of `CustomAnySequence` from an iterator.
  ///
  /// - Parameter iterator: The iterator to use to generate the sequence.
  public init<I: IteratorProtocol>(_ iterator: I) where I.Element == Element {
    _makeIterator = {
      AnyIterator(iterator)
    }
  }

  /// Creates a new instance of `CustomAnySequence` from a sequence.
  ///
  /// - Parameter sequence: The sequence to use to generate the sequence.
  public init<S: Sequence>(_ sequence: S) where S.Element == Element {
    _makeIterator = {
      AnyIterator(sequence.makeIterator())
    }
  }

  /// Returns an iterator over the elements of the sequence.
  ///
  /// - Returns: An iterator over the elements of the sequence.
  public func makeIterator() -> AnyIterator<Element> {
    return _makeIterator()
  }
}
