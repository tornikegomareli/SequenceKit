//
//  Count+LongCount.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

public extension Sequence {
  func count() -> Int {
    return reduce(0) { (count, _) in count + 1 }
  }
  
  func count(where predicate: (Element) -> Bool) -> Int {
    return reduce(0) { (count, element) in
      predicate(element) ? count + 1 : count
    }
  }
  
  func longCount() -> Int64 {
    return reduce(0) { (count, _) in count + 1 }
  }
  
  func longCount(where predicate: (Element) -> Bool) -> Int64 {
    return reduce(0) { (count, element) in
      predicate(element) ? count + 1 : count
    }
  }
}
