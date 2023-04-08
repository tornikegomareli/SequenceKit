//  GroupBy.swift
//  Created by Tornike on 08/04/2023.

import Foundation

/// A sequence that groups the elements of a base sequence based on a key and applies a transform to each element before grouping.
public struct TransformedGroupedSequence<S: Sequence, Key: Hashable, Value>: Sequence, IteratorProtocol {
  private var base: S.Iterator
  private let keyForValue: (S.Element) -> Key
  private let transform: (S.Element) -> Value
  private var cache: [Key: [Value]] = [:] // Cache for transformed values for each key.
  private var keys: Set<Key> = [] // Set to keep track of unique keys.

  public init(base: S, keyForValue: @escaping (S.Element) -> Key, transform: @escaping (S.Element) -> Value) {
    self.base = base.makeIterator()
    self.keyForValue = keyForValue
    self.transform = transform
  }

  /// Returns the next group of elements in the sequence, grouped by the key extracted from the elements and transformed into a value.
  ///
  /// - Returns: A tuple containing the key and the group of transformed values.
  public mutating func next() -> (Key, [Value])? {
    while let element = base.next() {
      let key = keyForValue(element)
      let transformedValue = transform(element)

      // If the key is not already in the set of unique keys, add it and create a new group.
      if keys.insert(key).inserted {
        cache[key] = [transformedValue]
      } else {
        // If the key is already in the set, append the transformed value to the existing group.
        cache[key]?.append(transformedValue)
      }

      if let group = cache[key], group.count > 1 {
        return (key, group)
      }
    }

    // If we've gone through the entire base sequence, iterate through the set of keys to find the first non-empty group.
    for key in keys {
      if let group = cache[key], !group.isEmpty {
        cache[key] = []
        return (key, group)
      }
    }

    return nil  // If we've gone through all the groups, return nil.
  }
}

/// A sequence that groups the elements of a base sequence based on a key.
public struct GroupedSequence<S: Sequence, Key: Hashable>: Sequence, IteratorProtocol {
  private var base: S.Iterator
  private let keyForValue: (S.Element) -> Key
  private var cache: [Key: [S.Element]] = [:]
  private var keys: Set<Key> = []

  public init(base: S, keyForValue: @escaping (S.Element) -> Key) {
    self.base = base.makeIterator()
    self.keyForValue = keyForValue
  }

  /// Returns the next group of elements in the sequence, grouped by the key extracted from the elements.
  ///
  /// - Returns: A tuple containing the key and the group of elements.
  public mutating func next() -> (Key, [S.Element])? {
    while let element = base.next() {
      let key = keyForValue(element)

      if keys.insert(key).inserted {
        cache[key] = [element]
      } else {
        // If the key is already in the set, append the element to the existing group.
        cache[key]?.append(element)
      }

      // If the group for this key has more than one element, return the key and the group.
      if let group = cache[key], group.count > 1 {
        return (key, group)
      }
    }

    // If we've gone through the entire base sequence, iterate through the set of keys to find the first non-empty group.
    for key in keys {
      if let group = cache[key], !group.isEmpty {
        cache[key] = []
        return (key, group)
      }
    }

    return nil
  }
}

/// An extension to the `Sequence` protocol that provides two functions for grouping elements in a sequence.
public extension Sequence {

  /// Groups the elements in the sequence based on a key extracted from each element using the provided closure.
  ///
  /// - Parameter keyForValue: A closure that takes an element from the sequence as input and returns a key for that element.
  ///
  /// - Returns: A `GroupedSequence` instance containing the grouped elements.
  func groupBy<Key: Hashable>(_ keyForValue: @escaping (Element) -> Key) -> GroupedSequence<Self, Key> {
    return GroupedSequence(base: self, keyForValue: keyForValue)
  }

  /// Groups the elements in the sequence based on a key extracted from each element using the provided closure, and applies a transform to each element before grouping.
  ///
  /// - Parameters:
  ///   - keyForValue: A closure that takes an element from the sequence as input and returns a key for that element.
  ///   - transform: A closure that takes an element from the sequence as input and returns a transformed value for that element.
  ///
  /// - Returns: A `TransformedGroupedSequence` instance containing the grouped and transformed elements.
  func groupBy<Key: Hashable, Value>(_ keyForValue: @escaping (Element) -> Key, _ transform: @escaping (Element) -> Value) -> TransformedGroupedSequence<Self, Key, Value> {
    return TransformedGroupedSequence(base: self, keyForValue: keyForValue, transform: transform)
  }
}

