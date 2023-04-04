//  Except.swift
//  Created by Tornike on 05/04/2023.

import Foundation

extension Sequence where Element: Hashable {
  // Returns a new sequence that contains the elements of the current sequence, except for those that are also in the other sequence.
  func except(_ other: Self) -> ExceptSequence<Self> {
    return ExceptSequence(first: self, second: other)
  }
}

struct ExceptSequence<Source: Sequence>: Sequence, IteratorProtocol where Source.Element: Hashable {
  private var firstIterator: Source.Iterator
  private var bannedElements: Set<Source.Element>
  private var seenElements = Set<Source.Element>()
  
  // Initializes a new `ExceptSequence` instance with two sequences.
  init(first: Source, second: Source) {
    self.firstIterator = first.makeIterator()
    self.bannedElements = Set(second)
  }
  
  // Returns the next element in the sequence, except for those that are also in the other sequence.
  mutating func next() -> Source.Element? {
    while let nextElement = firstIterator.next() {
      if !bannedElements.contains(nextElement), !seenElements.contains(nextElement) {
        seenElements.insert(nextElement)
        return nextElement
      }
    }
    return nil
  }
}
