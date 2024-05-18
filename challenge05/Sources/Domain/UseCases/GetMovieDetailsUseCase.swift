//
//  GetMovieDetailsUseCase.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation
import Combine

public protocol GetMovieDetailsUseCaseProtocol {
    func execute(movieId: Int, completion: ((Result<MovieDetails?, ErrorMessage>) -> Void)?)
}

public class GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {
    private var cancellabels = Set<AnyCancellable>()
    private var repo: MoviesRepositoryProtocol?
    
    init(repo: MoviesRepositoryProtocol? = MoviesRepositoryImp()) {
        self.repo = repo
    }
    
    public func execute(movieId: Int, completion: ((Result<MovieDetails?, ErrorMessage>) -> Void)?) {
        repo?.getMovieDetails(movieId: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { comp in
                if case let .failure(error) = comp {
                    completion?(.failure(error))
                }
            }, receiveValue: { data in
                completion?(.success(data))
            })
            .store(in: &cancellabels)
    }
}
