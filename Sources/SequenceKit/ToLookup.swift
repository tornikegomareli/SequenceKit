//  ToLookup.swift
//  Created by Tornike on 05/04/2023.

import Foundation

extension Sequence {
  /// Creates a lookup dictionary from the elements in the sequence.
  ///
  /// - Parameters:
  ///   - keySelector: A function that accepts an element and returns a key for that element.
  ///   - valueSelector: A function that accepts an element and returns a value for that element.
  ///
  /// - Returns: A dictionary where each key is associated with an array of values.
  func toLookup<Key: Hashable, Value>(
    keySelector: (Element) -> Key,
    valueSelector: (Element) -> Value
  ) -> [Key: [Value]] {
    var lookup = [Key: [Value]]()

    for element in self {
      let key = keySelector(element)
      let value = valueSelector(element)
      if var values = lookup[key] {
        values.append(value)
        lookup[key] = values
      } else {
        lookup[key] = [value]
      }
    }

    return lookup
  }
}
