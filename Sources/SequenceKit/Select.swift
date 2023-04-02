//
//  Select.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

public extension Sequence {
  func select<T>(_ transform: @escaping (Element) -> T) -> MapSequence<Self, T> {
    return MapSequence(base: self, transform: transform)
  }
}

public struct MapSequence<Base: Sequence, T>: Sequence {
  public typealias Element = T
  
  let base: Base
  let transform: (Base.Element) -> T
  
  public func makeIterator() -> Iterator {
    return Iterator(base: base.makeIterator(), transform: transform)
  }
  
  public struct Iterator: IteratorProtocol {
    public typealias Element = T
    
    var base: Base.Iterator
    let transform: (Base.Element) -> T
    
    public mutating func next() -> Element? {
      guard let element = base.next() else {
        return nil
      }
      return transform(element)
    }
  }
}
