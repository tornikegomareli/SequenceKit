//  Distinct.swift
//  Created by Tornike on 04/04/2023.
//

import Foundation

/// This file defines an extension to the `Sequence` protocol for creating a new sequence with only the unique elements from the original sequence.
public extension Sequence where Element: Hashable {

  /// Returns a new sequence with only the unique elements from the original sequence.
  ///
  /// - Returns: A new sequence with only the unique elements from the original sequence.
  func distinct() -> DistinctSequence<Self> {
    return DistinctSequence(source: self)
  }
}

/// A sequence that contains only the unique elements of the source sequence.
public struct DistinctSequence<Source: Sequence>: Sequence, IteratorProtocol where Source.Element: Hashable {

  private var iterator: Source.Iterator
  private var seenElements = Set<Source.Element>()

  /// Creates a new instance of `DistinctSequence` from a source sequence.
  ///
  /// - Parameter source: The source sequence.
  public init(source: Source) {
    self.iterator = source.makeIterator()
  }

  /// Returns the next unique element in the sequence, or `nil` if there are no more unique elements.
  ///
  /// - Returns: The next unique element in the sequence, or `nil` if there are no more unique elements.
  public mutating func next() -> Source.Element? {
    while let nextElement = iterator.next() {
      if !seenElements.contains(nextElement) {
        seenElements.insert(nextElement)
        return nextElement
      }
    }
    return nil
  }
}
