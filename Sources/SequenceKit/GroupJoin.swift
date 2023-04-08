//
//  GroupJoin.swift
//  
//
//  Created by Tornike on 09/04/2023.
//

import Foundation

public extension Sequence {
  func groupJoin<Inner: Sequence, Key: Hashable, Value>(inner: Inner, outerKeySelector: @escaping (Element) -> Key, innerKeySelector: @escaping (Inner.Element) -> Key, resultSelector: @escaping (Element, [Inner.Element]) -> Value) -> GroupJoinedSequence<Self, Inner, Key, Value> {
    return GroupJoinedSequence(outer: self, inner: inner, outerKeySelector: outerKeySelector, innerKeySelector: innerKeySelector, resultSelector: resultSelector)
  }
}

public struct GroupJoinedSequence<Outer: Sequence, Inner: Sequence, Key: Hashable, Value>: Sequence, IteratorProtocol {
  private var outerIterator: Outer.Iterator
  private let inner: Inner
  private let outerKeySelector: (Outer.Element) -> Key
  private let innerKeySelector: (Inner.Element) -> Key
  private let resultSelector: (Outer.Element, [Inner.Element]) -> Value

  public init(outer: Outer, inner: Inner, outerKeySelector: @escaping (Outer.Element) -> Key, innerKeySelector: @escaping (Inner.Element) -> Key, resultSelector: @escaping (Outer.Element, [Inner.Element]) -> Value) {
    self.outerIterator = outer.makeIterator()
    self.inner = inner
    self.outerKeySelector = outerKeySelector
    self.innerKeySelector = innerKeySelector
    self.resultSelector = resultSelector
  }

  public mutating func next() -> Value? {
    guard let outerElement = outerIterator.next() else { return nil }
    let outerKey = outerKeySelector(outerElement)
    let innerGroup = inner.filter { innerKeySelector($0) == outerKey }
    return resultSelector(outerElement, innerGroup)
  }
}
