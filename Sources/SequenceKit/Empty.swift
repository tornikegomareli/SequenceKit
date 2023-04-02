// Empty.swift
// Created by Tornike on 02/04/2023.

import Foundation

/// Returns an empty sequence of the given source type.
/// - Returns: An empty sequence of the given source type.
func GetEmptySequence<TSource>() -> EmptySequence<[TSource]> {
  return EmptySequence.instance
}

/// A struct representing an empty sequence of a given element type.
public struct EmptySequence<Element>: Sequence, IteratorProtocol {
  /// The iterator type for the sequence.
  public typealias Iterator = EmptySequence<Element>
  
  /// Initializes an `EmptySequence` instance.
  private init() {}
  
  /// The singleton instance of `EmptySequence`.
  public static var instance: EmptySequence<Element> {
    return EmptySequence<Element>()
  }
  
  /// Returns the iterator for the sequence.
  /// - Returns: The `EmptySequence` instance.
  public func makeIterator() -> EmptySequence<Element> {
    return self
  }
  
  /// Returns the next element in the sequence, which is always `nil`.
  /// - Returns: Always returns `nil`.
  public mutating func next() -> Element? {
    return nil
  }
}
