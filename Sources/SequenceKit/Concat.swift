//  Concat.swift
//  Created by Tornike on 02/04/2023.

import Foundation

public extension Sequence {
  func concat<S: Sequence>(_ other: S) -> ConcatenatedSequence<Self, S> where S.Element == Element {
    return ConcatenatedSequence(self, other)
  }
}

public struct ConcatenatedSequence<A: Sequence, B: Sequence>: Sequence where A.Element == B.Element {
  private let first: A
  private let second: B
  
  init(_ first: A, _ second: B) {
    self.first = first
    self.second = second
  }
  
  public func makeIterator() -> Iterator {
    return Iterator(first: first.makeIterator(), second: second.makeIterator())
  }
  
  public struct Iterator: IteratorProtocol {
    private var first: A.Iterator
    private var second: B.Iterator
    private var isFirstDone: Bool = false
    
    init(first: A.Iterator, second: B.Iterator) {
      self.first = first
      self.second = second
    }
    
    public mutating func next() -> A.Element? {
      if !isFirstDone {
        if let nextElement = first.next() {
          return nextElement
        } else {
          isFirstDone = true
        }
      }
      return second.next()
    }
  }
}
