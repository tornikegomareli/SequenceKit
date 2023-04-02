//  SelectMany.swift
//  Created by Tornike on 02/04/2023.

public extension Sequence {
  func selectMany<T, U>(_ collectionSelector: @escaping (Element, Int) -> AnySequence<T>,
                        _ resultSelector: @escaping (Element, T) -> U) -> SelectManyIndexedSequence<Self, T, U> {
    return SelectManyIndexedSequence(self, collectionSelector, resultSelector)
  }
  
  func selectMany<T>(_ selector: @escaping (Element) -> AnySequence<T>) -> SelectManySequence<Self, T> {
    return SelectManySequence(self, selector)
  }
}

public struct SelectManySequence<S: Sequence, T>: Sequence {
  private let source: S
  private let selector: (S.Element) -> AnySequence<T>
  
  public init(_ source: S, _ selector: @escaping (S.Element) -> AnySequence<T>) {
    self.source = source
    self.selector = selector
  }
  
  public func makeIterator() -> Iterator {
    return Iterator(source: source.makeIterator(), selector: selector)
  }
  
  public struct Iterator: IteratorProtocol {
    private var sourceIterator: S.Iterator
    private let selector: (S.Element) -> AnySequence<T>
    private var innerIterator: AnyIterator<T>?
    
    public init(source: S.Iterator, selector: @escaping (S.Element) -> AnySequence<T>) {
      self.sourceIterator = source
      self.selector = selector
    }
    
    public mutating func next() -> T? {
      while true {
        if let nextInner = innerIterator?.next() {
          return nextInner
        }
        if let nextOuter = sourceIterator.next() {
          innerIterator = selector(nextOuter).makeIterator()
        } else {
          return nil
        }
      }
    }
  }
}

public struct SelectManyIndexedSequence<S: Sequence, T, U>: Sequence {
  private let source: S
  private let collectionSelector: (S.Element, Int) -> AnySequence<T>
  private let resultSelector: (S.Element, T) -> U
  
  public init(_ source: S,
              _ collectionSelector: @escaping (S.Element, Int) -> AnySequence<T>,
              _ resultSelector: @escaping (S.Element, T) -> U) {
    self.source = source
    self.collectionSelector = collectionSelector
    self.resultSelector = resultSelector
  }
  
  public func makeIterator() -> Iterator {
    return Iterator(source: source.makeIterator(),
                    collectionSelector: collectionSelector,
                    resultSelector: resultSelector)
  }
  
  public struct Iterator: IteratorProtocol {
    private var sourceIterator: S.Iterator
    private let collectionSelector: (S.Element, Int) -> AnySequence<T>
    private let resultSelector: (S.Element, T) -> U
    private var innerIterator: AnyIterator<T>?
    private var index: Int = 0
    private var currentOuter: S.Element?
    
    init(source: S.Iterator,
         collectionSelector: @escaping (S.Element, Int) -> AnySequence<T>,
         resultSelector: @escaping (S.Element, T) -> U) {
      self.sourceIterator = source
      self.collectionSelector = collectionSelector
      self.resultSelector = resultSelector
    }
    
    public mutating func next() -> U? {
      while true {
        if let nextInner = innerIterator?.next() {
          if let currentOuter = currentOuter {
            return resultSelector(currentOuter, nextInner)
          } else {
            return nil
          }
        }
        if let nextOuter = sourceIterator.next() {
          currentOuter = nextOuter
          innerIterator = collectionSelector(nextOuter, index).makeIterator()
          index += 1
        } else {
          return nil
        }
      }
    }
  }
}
