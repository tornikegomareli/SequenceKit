//
//  Take+While+Skip+SkipWhile.swift
//  
//
//  Created by Tornike on 09/04/2023.
//

import Foundation

public extension Sequence {
  func skipWhile(_ predicate: @escaping (Element) -> Bool) -> SkipWhileSequence<Self> {
    return SkipWhileSequence(base: self, predicate: predicate)
  }
}

public extension Sequence {
  func take(_ count: Int) -> TakeSequence<Self> {
    return TakeSequence(base: self, count: count)
  }
}

public extension Sequence {
  func takeWhile(_ predicate: @escaping (Element) -> Bool) -> TakeWhileSequence<Self> {
    return TakeWhileSequence(base: self, predicate: predicate)
  }
}

public extension Sequence {
  func skip(_ count: Int) -> SkipSequence<Self> {
    return SkipSequence(base: self, count: count)
  }
}

public struct TakeSequence<S: Sequence>: Sequence, IteratorProtocol {
  private var base: S.Iterator
  private var count: Int

  public init(base: S, count: Int) {
    self.base = base.makeIterator()
    self.count = count
  }

  public mutating func next() -> S.Element? {
    guard count > 0 else { return nil }
    count = count - 1
    return base.next()
  }
}

public struct TakeWhileSequence<S: Sequence>: Sequence, IteratorProtocol {
  private var base: S.Iterator
  private let predicate: (S.Element) -> Bool

  public init(base: S, predicate: @escaping (S.Element) -> Bool) {
    self.base = base.makeIterator()
    self.predicate = predicate
  }

  public mutating func next() -> S.Element? {
    guard let element = base.next(), predicate(element) else { return nil }
    return element
  }
}

public struct SkipSequence<S: Sequence>: Sequence, IteratorProtocol {
  private var base: S.Iterator
  private var count: Int

  public init(base: S, count: Int) {
    self.base = base.makeIterator()
    self.count = count
  }

  public mutating func next() -> S.Element? {
    while count > 0, base.next() != nil {
      count -= 1
    }
    return base.next()
  }
}

public struct SkipWhileSequence<S: Sequence>: Sequence, IteratorProtocol {
  private var base: S.Iterator
  private let predicate: (S.Element) -> Bool
  private var skipped: Bool = false
  private var done: Bool = false

  init(base: S, predicate: @escaping (S.Element) -> Bool) {
    self.base = base.makeIterator()
    self.predicate = predicate
  }

  public mutating func next() -> S.Element? {
    guard !done else { return base.next() }

    while let element = base.next() {
      if !predicate(element) {
        done = true
        return element
      }
    }

    done = true
    return nil
  }
}
