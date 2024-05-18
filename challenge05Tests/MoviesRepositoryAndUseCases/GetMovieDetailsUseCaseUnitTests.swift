//
//  GetMovieDetailsUseCaseUnitTests.swift
//  challenge05Tests
//
//  Created by Mina Hanna on 2024-05-18.
//

import XCTest
@testable import challenge05

final class GetMovieDetailsUseCaseUnitTests: XCTestCase {
    var movieDetailsUseCase: GetMovieDetailsUseCase!
    var fakeMoviesRepository: FakeMoviesRepository!
    
    
    override func setUp() {
        super.setUp()
        
        fakeMoviesRepository = FakeMoviesRepository()
        movieDetailsUseCase = .init(repo: fakeMoviesRepository)
    }
    
    func testGetMoives_WithValidData_ShouldReturnMovies() {
        let expection = XCTestExpectation(description: "Get Movie Details")
        var response = ""
        movieDetailsUseCase.execute(movieId: 1223, completion:  {result in
            switch result {
            case .success(let movie):
                response = movie?.title ?? ""
                expection.fulfill()
            case .failure(_):
                break
            }
        })
        wait(for: [expection], timeout: 5)
        XCTAssertEqual(response, "Dune")
    }
    
    func testGetMoives_WithInValidData_ShouldReturnFailed() {
        let expection = XCTestExpectation(description: "Get Movie Details")
        var response: ErrorMessage?
        fakeMoviesRepository.setTestCaseState(testCaseState: .fail)
        movieDetailsUseCase?.execute(movieId: 1223,completion: { result in
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
