//
//  ReachabilityManagerTest.swift
//  challenge05Tests
//
//  Created by Mina Hanna on 2024-05-15.
//

import XCTest
@testable import challenge05

final class ReachabilityManagerTest: XCTestCase {
    let reachability = Reachability.shared
    
    func testReachability() throws {
        let reachable = reachability.isConnectedToNetwork()
        XCTAssertEqual(reachable, true)
    }
    
}
