//
//  File.swift
//  
//
//  Created by Tornike on 09/04/2023.
//

import Foundation
import XCTest
@testable import SequenceKit

class GroupJoinTests: XCTestCase {
  struct Person {
    let id: Int
    let name: String
  }

  struct Order {
    let id: Int
    let customerId: Int
  }

  var customers: [Person] = []
  var orders: [Order] = []

  override func setUp() {
    super.setUp()

    customers = [
      Person(id: 1, name: "Alice"),
      Person(id: 2, name: "Bob"),
      Person(id: 3, name: "Charlie"),
    ]

    orders = [
      Order(id: 1, customerId: 1),
      Order(id: 2, customerId: 2),
      Order(id: 3, customerId: 1),
      Order(id: 4, customerId: 3),
    ]
  }

  func testGroupJoin() {
    let customerOrders = customers.groupJoin(inner: orders, outerKeySelector: { $0.id }, innerKeySelector: { $0.customerId }, resultSelector: { (customer, orders) in
      return (customer.name, orders.map { $0.id })
    })

    var results: [(String, [Int])] = []
    for item in customerOrders {
      results.append(item)
    }

    XCTAssertEqual(results.count, 3)

    let aliceOrders = results.first { $0.0 == "Alice" }?.1
    XCTAssertEqual(aliceOrders?.count, 2)
    XCTAssertTrue(aliceOrders?.contains(1) ?? false)
    XCTAssertTrue(aliceOrders?.contains(3) ?? false)

    let bobOrders = results.first { $0.0 == "Bob" }?.1
    XCTAssertEqual(bobOrders?.count, 1)
    XCTAssertTrue(bobOrders?.contains(2) ?? false)

    let charlieOrders = results.first { $0.0 == "Charlie" }?.1
    XCTAssertEqual(charlieOrders?.count, 1)
    XCTAssertTrue(charlieOrders?.contains(4) ?? false)
  }
}
