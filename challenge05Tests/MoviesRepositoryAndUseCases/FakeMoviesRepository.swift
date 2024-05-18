//
//  FakeMoviesRepository.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-17.
//

import Foundation
import Combine
@testable import challenge05

enum ResultStates {
    case success
    case fail
}

public class FakeMoviesRepository: MoviesRepositoryProtocol {
    
    
    var testCaseState: ResultStates = .success
    
    func setTestCaseState(testCaseState: ResultStates) {
        self.testCaseState = testCaseState
    }
    
    public func getPopulerMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        switch testCaseState {
        case .success:
            return Just(Movies(page: 1, results: [Movie(adult: false, id: 1200, originalTitle: "Marvel", posterPath: "/image", releaseDate: "29-4-2024", title: "Marvel"), Movie(adult: false, id: 1200, originalTitle: "Justice", posterPath: "/image", releaseDate: "29-4-2024", title: "Justice")], totalPages: 1, totalResults: 1))
                .setFailureType(to: ErrorMessage.self)
                .eraseToAnyPublisher()
        case .fail:
            return Fail(error: ErrorMessage.InvalidData).eraseToAnyPublisher()
        }
    }
    
    public func getUpcomingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        switch testCaseState {
        case .success:
            return Just(Movies(page: 1, results: [Movie(adult: false, id: 1200, originalTitle: "Killer", posterPath: "/image", releaseDate: "29-4-2024", title: "Killer"), Movie(adult: false, id: 1200, originalTitle: "Suits", posterPath: "/image", releaseDate: "29-4-2024", title: "Suits")], totalPages: 1, totalResults: 1))
                .setFailureType(to: ErrorMessage.self)
                .eraseToAnyPublisher()
        case .fail:
            return Fail(error: ErrorMessage.InvalidResponse).eraseToAnyPublisher()
       
        }
    }
    public func getNowPlayingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        switch testCaseState {
        case .success:
            return Just(Movies(page: 1, results: [Movie(adult: false, id: 1200, originalTitle: "The Mask", posterPath: "/image", releaseDate: "29-4-2024", title: "The Mask"), Movie(adult: false, id: 1200, originalTitle: "LEO", posterPath: "/image", releaseDate: "29-4-2024", title: "LEO")], totalPages: 1, totalResults: 1))
                .setFailureType(to: ErrorMessage.self)
                .eraseToAnyPublisher()
        case .fail:
            return Fail(error: ErrorMessage.InvalidRequest).eraseToAnyPublisher()
     
        }
    }
    
    public func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetails, ErrorMessage> {
        switch testCaseState {
        case .success:
            return Just(MovieDetails(adult: false, budget: 2400, genres: nil, id: 1223, imdbID: nil, originalLanguage: nil, originalTitle: "Dune", overview: "Great Movie", popularity: nil, posterPath: nil, releaseDate: nil, revenue: nil, runtime: nil, status: nil, tagline: nil, title: "Dune", video: nil, voteAverage: nil, voteCount: nil))
                .setFailureType(to: ErrorMessage.self)
                .eraseToAnyPublisher()
        case .fail:
            return Fail(error: ErrorMessage.InvalidResponse).eraseToAnyPublisher()
        }
    }
}
