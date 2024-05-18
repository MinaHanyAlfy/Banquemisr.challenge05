//
//  MoviesRepositoryProtocol.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation
import Combine

public protocol MoviesRepositoryProtocol {
    func getPopulerMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage>
    func getNowPlayingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage>
    func getUpcomingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage>
    func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetails, ErrorMessage>
}
