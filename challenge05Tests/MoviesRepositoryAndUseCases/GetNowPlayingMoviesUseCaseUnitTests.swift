//
//  GetNowPlayingMoviesUseCaseUnitTests.swift
//  challenge05Tests
//
//  Created by Mina Hanna on 2024-05-18.
//

import XCTest
@testable import challenge05

final class GetNowPlayingMoviesUseCaseUnitTests: XCTestCase {
    var playingMoviesUseCase: GetPlayingMoviesUseCase!
    var fakeMoviesRepository: FakeMoviesRepository!
    
    
    override func setUp() {
        super.setUp()
        
        fakeMoviesRepository = FakeMoviesRepository()
        playingMoviesUseCase = .init(repo: fakeMoviesRepository)
    }
    
    func testGetMoives_WithValidData_ShouldReturnMovies() {
        let expection = XCTestExpectation(description: "Get NowPlaying Movies")
        var response = ""
        playingMoviesUseCase.execute(completion:  {result in
            switch result {
            case .success(let movies):
                response =  movies?.first?.title ?? ""
                expection.fulfill()
            case .failure(_):
                break
            }
        })
        wait(for: [expection], timeout: 5)
        XCTAssertEqual(response, "The Mask")
    }
    
    func testGetMoives_WithInValidData_ShouldReturnFailed() {
        let expection = XCTestExpectation(description: "Get NowPlaying Movies")
        var response: ErrorMessage?
        fakeMoviesRepository.setTestCaseState(testCaseState: .fail)
        playingMoviesUseCase?.execute(completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let fail):
                response = fail
                expection.fulfill()
            }
        })
        wait(for: [expection], timeout: 5)
        XCTAssertEqual(response, ErrorMessage.InvalidRequest )
    }
}
