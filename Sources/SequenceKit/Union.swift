//
//  File.swift
//  
//
//  Created by Tornike on 05/04/2023.
//

/// This file defines an extension of the `Sequence` protocol that provides a method `union` for finding the union of two sequences.
/// It also contains the implementation of the `UnionSequence` struct which represents a sequence that is the union of two sequences.
/// The elements in the sequences must be `Hashable`.
public extension Sequence where Element: Hashable {

  /// Returns a new sequence that contains all the distinct elements of both the original sequence and the given sequence.
  ///
  /// - Parameter other: Another sequence to union with.
  /// - Returns: A new sequence that is the union of both the original sequence and the given sequence.
  func union(_ other: Self) -> UnionSequence<Self> {
    return UnionSequence(first: self, second: other)
  }
}

/// A sequence that is the union of two sequences. The elements in the sequences must be `Hashable`.
public struct UnionSequence<Source: Sequence>: Sequence, IteratorProtocol where Source.Element: Hashable {

  // The iterators of the two sequences
  private var firstIterator: Source.Iterator
  private var secondIterator: Source.Iterator

  // A set to keep track of the elements already seen
  private var seenElements = Set<Source.Element>()

  /// Creates a new instance of `UnionSequence`.
  ///
  /// - Parameters:
  ///   - first: The first sequence to be included in the union.
  ///   - second: The second sequence to be included in the union.
  public init(first: Source, second: Source) {
    self.firstIterator = first.makeIterator()
    self.secondIterator = second.makeIterator()
  }

  /// Returns the next element in the union of the two sequences, or `nil` if there are no more elements.
  ///
  /// - Returns: The next element in the union of the two sequences, or `nil` if there are no more elements.
  public mutating func next() -> Source.Element? {
    while let nextElement = firstIterator.next() {
      if !seenElements.contains(nextElement) {
        seenElements.insert(nextElement)
        return nextElement
      }
    }

    while let nextElement = secondIterator.next() {
      if !seenElements.contains(nextElement) {
        seenElements.insert(nextElement)
        return nextElement
      }
    }

    return nil
  }
}
