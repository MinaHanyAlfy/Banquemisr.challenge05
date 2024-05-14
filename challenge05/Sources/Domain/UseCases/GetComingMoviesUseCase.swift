//
//  GetComingMoviesUseCase.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation
import Combine

protocol GetcomingMoviesUseCaseProtocol {
    func execute(completion: ((Result<[Movie]?, ErrorMessage>) -> Void)?)
}

class GetcomingMoviesUseCase: GetcomingMoviesUseCaseProtocol {
    private var cancellabels = Set<AnyCancellable>()
    var repo: MoviesRepositoryProtocol?
    
    init(repo: MoviesRepositoryProtocol? = MoviesRepositoryImp()) {
        self.repo = repo
    }
    
    func execute(completion: ((Result<[Movie]?, ErrorMessage>) -> Void)?) {
        repo?.getUpcomingMovies(page: 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { comp in
                if case let .failure(error) = comp {
                    completion?(.failure(error))
                }
            }, receiveValue: { data in
                completion?(.success(data.results))
            })
            .store(in: &cancellabels)
    }
}

