//
//  Empty.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

func GetEmptySequence<TSource>() -> EmptySequence<[TSource]> {
  return EmptySequence.instance
}

public struct EmptySequence<Element>: Sequence, IteratorProtocol {
  public typealias Iterator = EmptySequence<Element>
  
  private init() {}
  
  public static var instance: EmptySequence<Element> {
    return EmptySequence<Element>()
  }
  
  public func makeIterator() -> EmptySequence<Element> {
    return self
  }
  
  public mutating func next() -> Element? {
    return nil
  }
}
