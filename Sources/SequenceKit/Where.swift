//
//  Where.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

extension Sequence {
  func `where`(_ predicate: @escaping (Element) -> Bool) -> WhereSequence<Self> {
    return WhereSequence(base: self, predicate: predicate)
  }
}

struct WhereSequence<Base: Sequence>: Sequence {
  typealias Element = Base.Element
  
  let base: Base
  let predicate: (Element) -> Bool
  
  func makeIterator() -> Iterator {
    return Iterator(base: base.makeIterator(), predicate: predicate)
  }
  
  struct Iterator: IteratorProtocol {
    typealias Element = Base.Element
    
    var base: Base.Iterator
    let predicate: (Element) -> Bool
    
    mutating func next() -> Element? {
      while let element = base.next() {
        if predicate(element) {
          return element
        }
      }
      return nil
    }
  }
}

