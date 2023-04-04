//  Intersect.swift
//  Created by Tornike on 05/04/2023.

import Foundation

public extension Sequence where Element: Hashable {
  /// Returns a sequence of elements that are present in both this sequence and another sequence.
  ///
  /// - Parameter other: The other sequence to intersect with.
  /// - Returns: An `IntersectSequence` that iterates over the elements present in both this sequence and the other sequence.
  func intersect(_ other: Self) -> IntersectSequence<Self> {
    return IntersectSequence(first: self, second: other)
  }
}

public struct IntersectSequence<Source: Sequence>: Sequence, IteratorProtocol where Source.Element: Hashable {
  private var firstIterator: Source.Iterator
  private var secondSet: Set<Source.Element>
  private var seenElements = Set<Source.Element>()
  
  /// Initializes a new `IntersectSequence` with two sequences to intersect.
  ///
  /// - Parameters:
  ///   - first: The first sequence to intersect.
  ///   - second: The second sequence to intersect.
  public init(first: Source, second: Source) {
    self.firstIterator = first.makeIterator()
    self.secondSet = Set(second)
  }
  
  /// Returns the next element of the intersected sequence.
  ///
  /// - Returns: The next element of the intersected sequence or `nil` if there are no more elements to iterate over.
  public mutating func next() -> Source.Element? {
    while let nextElement = firstIterator.next() {
      if secondSet.contains(nextElement), !seenElements.contains(nextElement) {
        seenElements.insert(nextElement)
        return nextElement
      }
    }
    return nil
  }
}
