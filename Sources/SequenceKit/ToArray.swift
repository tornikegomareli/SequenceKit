// ToArray.swift
// Created by Tornike on 02/04/2023.

import Foundation

public extension Sequence {
  /// Returns an array containing the elements of the sequence, in the same order.
  /// - Returns: An array containing the elements of the sequence, in the same order.
  func toArray() -> [Element] {
    return Array(self)
  }
}
