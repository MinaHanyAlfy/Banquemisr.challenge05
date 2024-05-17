//
//  GetPlayingMoviesUseCase.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation
import Combine

protocol GetPlayingMoviesUseCaseProtocol {
    func execute(completion: ((Result<[Movie]?, ErrorMessage>) -> Void)?)
}

class GetPlayingMoviesUseCase: GetPlayingMoviesUseCaseProtocol {
    private var cancellabels = Set<AnyCancellable>()
    var repo: MoviesRepositoryProtocol?
    private var currentPage = 1
    private var totalPages = 1
    
    init(repo: MoviesRepositoryProtocol? = MoviesRepositoryImp()) {
        self.repo = repo
    }
    
    func execute(completion: ((Result<[Movie]?, ErrorMessage>) -> Void)?) {
        if currentPage <= totalPages || currentPage == 1  {
            repo?.getNowPlayingMovies(page: currentPage)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { comp in
                    if case let .failure(error) = comp {
                        completion?(.failure(error))
                    }
                }, receiveValue: { data in
                    completion?(.success(data.results))
                    self.totalPages = data.totalPages ?? 0
                    self.currentPage += 1
                })
                .store(in: &cancellabels)
        } else {
            completion?(.success([]))
        }
    }
}


