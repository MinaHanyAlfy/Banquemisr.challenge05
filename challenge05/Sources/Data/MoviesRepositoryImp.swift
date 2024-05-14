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
    
    func getPopulerMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        let subject = PassthroughSubject<Movies, ErrorMessage>()
        let configurationRequest = MoviesRouter.getPopulerMovies(page: page)
        let publisher = subject.eraseToAnyPublisher()
        
            RequestManager.beginRequest(request: configurationRequest, model: Movies.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                })
                .store(in: &cancellabels)
            return publisher
    }
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        let subject = PassthroughSubject<Movies, ErrorMessage>()
        let configurationRequest = MoviesRouter.getPlayingMovies(page: page)
        let publisher = subject.eraseToAnyPublisher()
        
        RequestManager.beginRequest(request: configurationRequest, model: Movies.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                })
                .store(in: &cancellabels)
            return publisher
    }
    
    func getUpcomingMovies(page: Int) -> AnyPublisher<Movies, ErrorMessage> {
        let subject = PassthroughSubject<Movies, ErrorMessage>()
        let configurationRequest = MoviesRouter.getUpcomingMovies(page: page)
        let publisher = subject.eraseToAnyPublisher()
        
        RequestManager.beginRequest(request: configurationRequest, model: Movies.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                })
                .store(in: &cancellabels)
            return publisher
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetails, ErrorMessage> {
        let subject = PassthroughSubject<MovieDetails, ErrorMessage>()
        let configurationRequest = MoviesRouter.getMovieDetails(movieId: movieId)
        let publisher = subject.eraseToAnyPublisher()
        
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
    }
}
