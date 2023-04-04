//  Any+All.swift
//  Created by Tornike on 04/04/2023.
//

import Foundation

public extension Sequence {
  func any() -> Bool {
    return CustomAnySequence(self).makeIterator().next() != nil
  }
  
  func any(where predicate: (Element) -> Bool) -> Bool {
    let customSequence = CustomAnySequence(self)
    for element in customSequence {
      if predicate(element) {
        return true
      }
    }
    return false
  }
  
  func all(where predicate: (Element) -> Bool) -> Bool {
    let customSequence = CustomAnySequence(self)
    for element in customSequence {
      if !predicate(element) {
        return false
      }
    }
    return true
  }
}

public struct CustomAnySequence<Element>: Sequence {
  private let _makeIterator: () -> AnyIterator<Element>
  
  public init<I: IteratorProtocol>(_ iterator: I) where I.Element == Element {
    _makeIterator = {
      AnyIterator(iterator)
    }
  }
  
  public init<S: Sequence>(_ sequence: S) where S.Element == Element {
    _makeIterator = {
      AnyIterator(sequence.makeIterator())
    }
  }
  
  public func makeIterator() -> AnyIterator<Element> {
    return _makeIterator()
  }
}
