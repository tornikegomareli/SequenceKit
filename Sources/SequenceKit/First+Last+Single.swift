//  First+Last+Single.swift
//  Created by Tornike on 04/04/2023.
//

import Foundation
//  First+Last+Single.swift
//  Created by Tornike on 04/04/2023.
//

import Foundation

public extension Sequence {

  // Returns the first element in the sequence that satisfies the given predicate, or throws an error if no element is found or if more than one element is found.
  func first(where predicate: (Element) -> Bool) throws -> Element {
    var result: Element? = nil
    for element in self {
      if predicate(element) {
        if result == nil {
          result = element
        } else {
          throw NSError(domain: "Multiple elements found", code: 101, userInfo: nil)
        }
      }
    }

    guard let firstElement = result else {
      throw NSError(domain: "Empty sequence", code: 100, userInfo: nil)
    }
    return firstElement
  }

  // Returns the first element in the sequence that satisfies the given predicate, or nil if no element is found.
  func firstOrDefault(where predicate: (Element) -> Bool) -> Element? {
    return self.first(where: predicate)
  }

  // Returns the last element in the sequence that satisfies the given predicate, or throws an error if no element is found.
  func last(where predicate: (Element) -> Bool) throws -> Element {
    var lastElement: Element? = nil
    for element in self {
      if predicate(element) {
        lastElement = element
      }
    }

    guard let result = lastElement else {
      throw NSError(domain: "Empty sequence", code: 100, userInfo: nil)
    }
    return result
  }

  // Returns the last element in the sequence that satisfies the given predicate, or nil if no element is found.
  func lastOrDefault(where predicate: (Element) -> Bool) -> Element? {
    var lastElement: Element? = nil
    for element in self {
      if predicate(element) {
        lastElement = element
      }
    }
    return lastElement
  }

  // Returns the single element in the sequence that satisfies the given predicate, or throws an error if no element is found or if more than one element is found.
  func single(where predicate: (Element) -> Bool) throws -> Element {
    var result: Element? = nil
    for element in self {
      if predicate(element) {
        if result == nil {
          result = element
        } else {
          throw NSError(domain: "Multiple elements found", code: 101, userInfo: nil)
        }
      }
    }

    guard let singleElement = result else {
      throw NSError(domain: "Empty sequence", code: 100, userInfo: nil)
    }
    return singleElement
  }

  // Returns the single element in the sequence that satisfies the given predicate, or nil if no element is found or if more than one element is found.
  func singleOrDefault(where predicate: (Element) -> Bool) -> Element? {
    var result: Element? = nil
    for element in self {
      if predicate(element) {
        if result == nil {
          result = element
        } else {
          return nil
        }
      }
    }
    return result
  }
}
