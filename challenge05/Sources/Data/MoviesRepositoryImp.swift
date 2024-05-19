//
//  MoviesRepositoryImp.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation
import Combine

///To Implement Movie Module Repository Protocol
///Using Router for to create api request
///Send api request to request mangaer
public class MoviesRepositoryImp: MoviesRepositoryProtocol {
    private var cancellabels = Set<AnyCancellable>()
    public  var reachability = Reachability.shared
    private let coreData = CoreDataManager.shared

    public init() {}
    
    
    public func getPopulerMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        let subject = PassthroughSubject<Movies, ErrorMessage>()
        let configurationRequest = MoviesRouter.getPopulerMovies(page: page)
        let publisher = subject.eraseToAnyPublisher()
        if reachability.isConnectedToNetwork() {
            RequestManager.beginRequest(request: configurationRequest, model: Movies.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                    self.coreData.saveMovies(movies: repos.results ?? [], type: .Populer)

                })
                .store(in: &cancellabels)
            return publisher
        } else {
            if coreData.fetchMovies(type: .Populer).count == 0 {
                subject.send(completion: .failure(.NoInternet))
                return publisher
            } else {
                if coreData.fetchMovies(type: .Populer).count == 0 {
                    subject.send(completion: .failure(.NoInternet))
                    return publisher
                } else {
                    let movies = Movies(page: 1, results: coreData.fetchMovies(type: .Populer), totalPages: 1, totalResults: 1)
                    return Just(movies)
                        .setFailureType(to: ErrorMessage.self)
                        .eraseToAnyPublisher()
                }
            }
        }
    }
    
    public func getNowPlayingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        let subject = PassthroughSubject<Movies, ErrorMessage>()
        let configurationRequest = MoviesRouter.getPlayingMovies(page: page)
        let publisher = subject.eraseToAnyPublisher()
        
        if reachability.isConnectedToNetwork() {
            RequestManager.beginRequest(request: configurationRequest, model: Movies.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                    self.coreData.saveMovies(movies: repos.results ?? [], type: .NowPlaying)

                })
                .store(in: &cancellabels)
            return publisher
        } else {
            if coreData.fetchMovies(type: .NowPlaying).count == 0 {
                subject.send(completion: .failure(.NoInternet))
                return publisher
            } else {
                let movies = Movies(page: 1, results: coreData.fetchMovies(type: .NowPlaying), totalPages: 1, totalResults: 1)
                return Just(movies)
                    .setFailureType(to: ErrorMessage.self)
                    .eraseToAnyPublisher()
            }
        }
    }
    
    public func getUpcomingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        let subject = PassthroughSubject<Movies, ErrorMessage>()
        let configurationRequest = MoviesRouter.getUpcomingMovies(page: page)
        let publisher = subject.eraseToAnyPublisher()
        
        if reachability.isConnectedToNetwork() {
            RequestManager.beginRequest(request: configurationRequest, model: Movies.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                    self.coreData.saveMovies(movies: repos.results ?? [], type: .Upcoming)
                })
                .store(in: &cancellabels)
            return publisher
        } else {
            if coreData.fetchMovies(type: .Upcoming).count == 0 {
                subject.send(completion: .failure(.NoInternet))
                return publisher
            } else {
                let movies = Movies(page: 1, results: coreData.fetchMovies(type: .Upcoming), totalPages: 1, totalResults: 1)
                return Just(movies)
                    .setFailureType(to: ErrorMessage.self)
                    .eraseToAnyPublisher()
            }
        }
    }
    
    public func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetails, ErrorMessage> {
        let subject = PassthroughSubject<MovieDetails, ErrorMessage>()
        let configurationRequest = MoviesRouter.getMovieDetails(movieId: movieId)
        let publisher = subject.eraseToAnyPublisher()
        
        if reachability.isConnectedToNetwork() {
            RequestManager.beginRequest(request: configurationRequest, model: MovieDetails.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                })
                .store(in: &cancellabels)
            return publisher
        } else {
            subject.send(completion: .failure(.NoInternet))
            return publisher
        }
    }
}
