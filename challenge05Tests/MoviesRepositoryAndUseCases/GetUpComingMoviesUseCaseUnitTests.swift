//
//  GetUpComingMoviesUseCaseUnitTests.swift
//  challenge05Tests
//
//  Created by Mina Hanna on 2024-05-18.
//

import XCTest
@testable import challenge05

final class GetUpComingMoviesUseCaseUnitTests: XCTestCase {
    var comingMoviesUseCase: GetComingMoviesUseCase!
    var fakeMoviesRepository: FakeMoviesRepository!
    
    
    override func setUp() {
        super.setUp()
        
        fakeMoviesRepository = FakeMoviesRepository()
        comingMoviesUseCase = .init(repo: fakeMoviesRepository)
    }
    
    func testGetMoives_WithValidData_ShouldReturnMovies() {
        let expection = XCTestExpectation(description: "Get UpComing Movies")
        var response = ""
        comingMoviesUseCase.execute(completion:  {result in
            switch result {
            case .success(let movies):
                response =  movies?[1].title ?? ""
                expection.fulfill()
            case .failure(_):
                break
            }
        })
        wait(for: [expection], timeout: 5)
        XCTAssertEqual(response, "Suits")
    }
    
    func testGetMoives_WithInValidData_ShouldReturnFailed() {
        let expection = XCTestExpectation(description: "Get UpComing Movies")
        var response: ErrorMessage?
        fakeMoviesRepository.setTestCaseState(testCaseState: .fail)
        comingMoviesUseCase?.execute(completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let fail):
                response = fail
                expection.fulfill()
            }
        })
        wait(for: [expection], timeout: 5)
        XCTAssertEqual(response, ErrorMessage.InvalidResponse )
    }

}
