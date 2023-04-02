//
//  Select.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

public extension Sequence {
  func select<TSource>(_ transform: @escaping (Element) -> TSource) -> MapSequence<Self, TSource> {
    return MapSequence(base: self, transform: transform)
  }
}

public struct MapSequence<Base: Sequence, TSource>: Sequence {
  public typealias Element = TSource
  
  let base: Base
  let transform: (Base.Element) -> TSource
  
  public func makeIterator() -> Iterator {
    return Iterator(base: base.makeIterator(), transform: transform)
  }
  
  public struct Iterator: IteratorProtocol {
    public typealias Element = TSource
    
    var base: Base.Iterator
    let transform: (Base.Element) -> TSource
    
    public mutating func next() -> Element? {
      guard let element = base.next() else {
        return nil
      }
      return transform(element)
    }
  }
}
