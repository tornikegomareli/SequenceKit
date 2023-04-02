//
//  File.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

public func repeatElement<T>(_ element: T, count: Int) -> RepeatSequence<T> {
  return RepeatSequence(sequence: element, count: count)
}

public struct RepeatSequence<SequenceType: Sequence>: Sequence {
  let sequence: SequenceType
  let count: Int
  
  public init(sequence: SequenceType, count: Int) {
    self.sequence = sequence
    self.count = count
  }
  
  public func makeIterator() -> RepeatIterator<SequenceType.Iterator> {
    return RepeatIterator(element: sequence.makeIterator(), count: count)
  }
}

public struct RepeatIterator<T>: IteratorProtocol {
  let element: T
  var count: Int
  
  init(element: T, count: Int) {
    self.element = element
    self.count = count
  }
  
  public mutating func next() -> T? {
    guard count > 0 else { return nil }
    count -= 1
    return element
  }
}
