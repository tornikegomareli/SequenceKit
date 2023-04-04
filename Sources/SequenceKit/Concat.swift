//  Concat.swift
//  Created by Tornike on 02/04/2023.

/// This file defines an extension of the `Sequence` protocol that provides a method `concat` for concatenating two sequences.
/// It also contains the implementation of the `ConcatenatedSequence` struct which represents a sequence that is the concatenation of two sequences.
public extension Sequence {
  
  /// Returns a new sequence that concatenates the original sequence with the given sequence.
  ///
  /// - Parameter other: Another sequence to concatenate with.
  /// - Returns: A new sequence that is the concatenation of the original sequence and the given sequence.
  func concat<S: Sequence>(_ other: S) -> ConcatenatedSequence<Self, S> where S.Element == Element {
    return ConcatenatedSequence(self, other)
  }
}

/// A sequence that is the concatenation of two sequences.
public struct ConcatenatedSequence<A: Sequence, B: Sequence>: Sequence where A.Element == B.Element {
  
  private let first: A
  private let second: B
  
  /// Creates a new instance of `ConcatenatedSequence`.
  ///
  /// - Parameters:
  ///   - first: The first sequence to be concatenated.
  ///   - second: The second sequence to be concatenated.
  init(_ first: A, _ second: B) {
    self.first = first
    self.second = second
  }
  
  /// Returns an iterator over the concatenated sequence.
  ///
  /// - Returns: An iterator over the concatenated sequence.
  public func makeIterator() -> Iterator {
    return Iterator(first: first.makeIterator(), second: second.makeIterator())
  }
  
  /// An iterator for the `ConcatenatedSequence` struct.
  public struct Iterator: IteratorProtocol {
    
    private var first: A.Iterator
    private var second: B.Iterator
    private var isFirstDone: Bool = false
    
    /// Creates a new instance of `Iterator`.
    ///
    /// - Parameters:
    ///   - first: The iterator of the first sequence to be concatenated.
    ///   - second: The iterator of the second sequence to be concatenated.
    init(first: A.Iterator, second: B.Iterator) {
      self.first = first
      self.second = second
    }
    
    /// Returns the next element in the concatenated sequence, or `nil` if there are no more elements.
    ///
    /// - Returns: The next element in the concatenated sequence, or `nil` if there are no more elements.
    public mutating func next() -> A.Element? {
      if !isFirstDone {
        if let nextElement = first.next() {
          return nextElement
        } else {
          isFirstDone = true
        }
      }
      return second.next()
    }
  }
}
