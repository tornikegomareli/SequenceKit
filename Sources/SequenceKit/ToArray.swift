//
//  ToArray.swift
//  
//
//  Created by Tornike on 02/04/2023.
//

import Foundation

extension Sequence {
  func toArray() -> [Element] {
    return Array(self)
  }
}
