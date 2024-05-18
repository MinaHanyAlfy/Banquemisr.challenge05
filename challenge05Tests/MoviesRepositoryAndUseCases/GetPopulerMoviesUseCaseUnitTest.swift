//
//  GetPopulerMoviesUseCaseUnitTest.swift
//  challenge05Tests
//
//  Created by Mina Hanna on 2024-05-17.
//

import XCTest
@testable import challenge05

final class GetPopulerMoviesUseCaseUnitTest: XCTestCase {
    var populerMoviesUseCase: GetPopulerMoviesUseCase!
    var fakeMoviesRepository: FakeMoviesRepository!
    
    
    override func setUp() {
        super.setUp()
        
        fakeMoviesRepository = FakeMoviesRepository()
        populerMoviesUseCase = .init(repo: fakeMoviesRepository)
    }
    
    func testGetMoives_WithValidData_ShouldReturnMovies() {
        let expection = XCTestExpectation(description: "Get Populer Movies")
        var response = ""
        populerMoviesUseCase.execute(completion:  {result in
            switch result {
            case .success(let movies):
                response =  movies?.first?.title ?? ""
                expection.fulfill()
            case .failure(_):
                break
            }
        })
        wait(for: [expection], timeout: 5)
        XCTAssertEqual(response, "Marvel")
    }
    
    func testGetMoives_WithInValidData_ShouldReturnFailed() {
        let expection = XCTestExpectation(description: "Get Populer Movies")
        var response: ErrorMessage?
        fakeMoviesRepository.setTestCaseState(testCaseState: .fail)
        populerMoviesUseCase?.execute(completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let fail):
                response = fail
                expection.fulfill()
            }
        })
        wait(for: [expection], timeout: 5)
        XCTAssertEqual(response, ErrorMessage.InvalidData )
    }
}
