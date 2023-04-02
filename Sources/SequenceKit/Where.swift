//  Where.swift
//  Created by Tornike on 02/04/2023.

import Foundation

public extension Sequence {
  /// Filters the elements of the sequence based on a given predicate.
  /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element should be included in the result.
  /// - Returns: A sequence containing the elements that satisfy the given predicate.
  func `where`(_ predicate: @escaping (Element) -> Bool) -> WhereSequence<Self> {
    return WhereSequence(base: self, predicate: predicate)
  }
}

/// A sequence wrapper that filters the elements of a base sequence based on a given predicate.
public struct WhereSequence<Base: Sequence>: Sequence {
  /// The element type of the resulting sequence.
  public typealias Element = Base.Element
  
  /// The base sequence to filter.
  let base: Base
  /// The predicate to use to filter the elements of the base sequence.
  let predicate: (Element) -> Bool
  
  /// Returns an iterator that filters the elements of the base sequence based on the predicate.
  /// - Returns: An iterator that filters the elements of the base sequence based on the predicate.
  public func makeIterator() -> Iterator {
    return Iterator(base: base.makeIterator(), predicate: predicate)
  }
  
  /// An iterator that filters the elements of a base sequence based on a given predicate.
  public struct Iterator: IteratorProtocol {
    /// The element type of the resulting sequence.
    public typealias Element = Base.Element
    
    /// The base iterator to filter.
    var base: Base.Iterator
    /// The predicate to use to filter the elements of the base iterator.
    let predicate: (Element) -> Bool
    
    /// Returns the next element of the resulting sequence that satisfies the predicate.
    /// - Returns: The next element of the resulting sequence that satisfies the predicate, or nil if the base iterator has no more elements.
    public mutating func next() -> Element? {
      while let element = base.next() {
        if predicate(element) {
          return element
        }
      }
      return nil
    }
  }
}
