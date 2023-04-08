//  Join.swift
//  Created by Tornike on 08/04/2023.

import Foundation

/// An extension on Sequence that provides a join function to join two sequences based on a key.
/// A function that joins two sequences based on the provided key selectors and returns a new sequence of TResult elements.
///
/// - Parameters:
///   - outer: The outer sequence of elements to join.
///   - inner: The inner sequence of elements to join.
///   - outerKeySelector: A closure that returns the key for an outer element.
///   - innerKeySelector: A closure that returns the key for an inner element.
///   - resultSelector: A closure that returns a TResult element from the combination of an outer and inner element.
///   - lookup: A closure that generates a lookup table from the inner sequence and its key selector.
/// - Returns: A JoinSequence instance that represents the joined sequence of TResult elements.
public func join<TOuter, TInner, TKey: Hashable, TResult>(
  outer: [TOuter],
  inner: [TInner],
  outerKeySelector: @escaping (TOuter) -> TKey,
  innerKeySelector: @escaping (TInner) -> TKey,
  resultSelector: @escaping (TOuter, TInner) -> TResult,
  lookup: @escaping ([TInner], (TInner) -> TKey) -> [TKey: [TInner]]
) -> JoinSequence<TOuter, TInner, TKey, TResult> {
  return JoinSequence(
    outer: outer,
    inner: inner,
    outerKeySelector: outerKeySelector,
    innerKeySelector: innerKeySelector,
    resultSelector: resultSelector,
    lookup: lookup
  )
}

/// A custom sequence that represents the joined elements from two sequences based on a key.
public struct JoinSequence<TOuter, TInner, TKey: Hashable, TResult>: Sequence, IteratorProtocol {
  private let outer: [TOuter]
  private let inner: [TInner]
  private let outerKeySelector: (TOuter) -> TKey
  private let innerKeySelector: (TInner) -> TKey
  private let resultSelector: (TOuter, TInner) -> TResult
  private let lookupTable: [TKey: [TInner]]
  private var outerIndex: Int = 0
  private var innerIndex: Int = 0
  private var currentKey: TKey?

  /// Initializes a JoinSequence with the provided sequences, key selectors, result selector, and lookup table generator.
  ///
  /// - Parameters:
  ///   - outer: The outer sequence of elements to join.
  ///   - inner: The inner sequence of elements to join.
  ///   - outerKeySelector: A closure that returns the key for an outer element.
  ///   - innerKeySelector: A closure that returns the key for an inner element.
  ///   - resultSelector: A closure that returns a TResult element from the combination of an outer and inner element.
  ///   - lookup: A closure that generates a lookup table from the inner sequence and its key selector.
  public init(
    outer: [TOuter],
    inner: [TInner],
    outerKeySelector: @escaping (TOuter) -> TKey,
    innerKeySelector: @escaping (TInner) -> TKey,
    resultSelector: @escaping (TOuter, TInner) -> TResult,
    lookup: ([TInner], (TInner) -> TKey) -> [TKey: [TInner]]
  ) {
    self.outer = outer
    self.inner = inner
    self.outerKeySelector = outerKeySelector
    self.innerKeySelector = innerKeySelector
    self.resultSelector = resultSelector
    self.lookupTable = lookup(inner, innerKeySelector)
  }

  /// Returns the next element in the joined sequence or nil if the sequence has ended.
  ///
  /// - Returns: An optional TResult element or nil if the sequence has ended.
  public mutating func next() -> TResult? {
    while outerIndex < outer.count {
      let outerElement = outer[outerIndex]
      let key = outerKeySelector(outerElement)

      if currentKey != key {
        currentKey = key
        innerIndex = 0
      }

      // If the current key exists in the lookup table and the inner index is within bounds,
      // return the result of applying the result selector to the current outer and inner elements.
      if let innerElements = lookupTable[key], innerIndex < innerElements.count {
        let innerElement = innerElements[innerIndex]
        innerIndex += 1
        return resultSelector(outerElement, innerElement)
      } else {
        outerIndex += 1
      }
    }

    return nil
  }
}

