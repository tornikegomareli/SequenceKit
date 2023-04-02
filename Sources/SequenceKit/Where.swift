//
//  Where.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

public extension Sequence {
  func `where`(_ predicate: @escaping (Element) -> Bool) -> WhereSequence<Self> {
    return WhereSequence(base: self, predicate: predicate)
  }
}

public struct WhereSequence<Base: Sequence>: Sequence {
  public typealias Element = Base.Element
  
  let base: Base
  let predicate: (Element) -> Bool
  
  public func makeIterator() -> Iterator {
    return Iterator(base: base.makeIterator(), predicate: predicate)
  }
  
  public struct Iterator: IteratorProtocol {
    public typealias Element = Base.Element
    
    var base: Base.Iterator
    let predicate: (Element) -> Bool
    
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

