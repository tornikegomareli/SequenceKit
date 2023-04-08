//
//  ToDictionary.swift
//  
//
//  Created by Tornike on 09/04/2023.
//

import Foundation

extension Sequence {
  func toDictionary<Key: Hashable, Value>(
    withKeys keys: (Element) throws -> Key,
    andValues values: (Element) throws -> Value
  ) rethrows -> [Key: Value] {

    var dictionary = [Key: Value]()
    for element in self {
      let key = try keys(element)
      let value = try values(element)
      dictionary[key] = value
    }

    return dictionary
  }
}
