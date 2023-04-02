// Select.swift
// Created by Tornike on 02/04/2023.

import Foundation

public extension Sequence {
  /// Projects each element of the sequence into a new form by applying a transform function.
  /// - Parameter transform: A closure that takes an element of the sequence as its argument and returns a transformed value.
  /// - Returns: A sequence of transformed values.
  func select<T>(_ transform: @escaping (Element) -> T) -> MapSequence<Self, T> {
    return MapSequence(base: self, transform: transform)
  }
}

/// A sequence wrapper that applies a transform function to each element of a base sequence.
public struct MapSequence<Base: Sequence, T>: Sequence {
  /// The element type of the resulting sequence.
  public typealias Element = T
  
  /// The base sequence to transform.
  let base: Base
  /// The transform function to apply to each element of the base sequence.
  let transform: (Base.Element) -> T
  
  /// Returns an iterator that applies the transform function to each element of the base sequence.
  /// - Returns: An iterator that applies the transform function to each element of the base sequence.
  public func makeIterator() -> Iterator {
    return Iterator(base: base.makeIterator(), transform: transform)
  }
  
  /// An iterator that applies the transform function to each element of a base iterator.
  public struct Iterator: IteratorProtocol {
    /// The element type of the resulting sequence.
    public typealias Element = T
    
    /// The base iterator to transform.
    var base: Base.Iterator
    /// The transform function to apply to each element of the base iterator.
    let transform: (Base.Element) -> T
    
    /// Returns the next element of the resulting sequence, transformed from the next element of the base iterator.
    /// - Returns: The next element of the resulting sequence, or nil if the base iterator has no more elements.
    public mutating func next() -> Element? {
      guard let element = base.next() else {
        return nil
      }
      return transform(element)
    }
  }
}
