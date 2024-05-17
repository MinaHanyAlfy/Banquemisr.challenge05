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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReachability() throws {
        let reachable = reachability.isConnectedToNetwork()
        XCTAssertEqual(reachable, true)
    }
    
}
