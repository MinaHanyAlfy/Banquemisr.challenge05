//
//  FakeMoviesRepository.swift
//  challenge05Tests
//
//  Created by Mina Hanna on 2024-05-18.
//

import Foundation
import Combine
@testable import challenge05

enum ResultStates {
    case success
    case failure
}
class FakeMoviesRepository: MoviesRepositoryProtocol {
    
    var testCaseState: ResultStates = .success
    
    func setTestCaseState(testCaseState: ResultStates) {
        self.testCaseState = testCaseState
    }
    
    func getPopulerMovies(page: Int) -> AnyPublisher<challenge05.Movies, challenge05.ErrorMessage> {
        switch testCaseState {
        case .success:
            <#code#>
        case .failure:
            <#code#>
        }
    }
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<challenge05.Movies, challenge05.ErrorMessage> {
        <#code#>
    }
    
    func getUpcomingMovies(page: Int) -> AnyPublisher<challenge05.Movies, challenge05.ErrorMessage> {
        <#code#>
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<challenge05.MovieDetails, challenge05.ErrorMessage> {
        <#code#>
    }
    
    
}
