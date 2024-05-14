//
//  ComingViewModel.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation

protocol ComingViewModelProtocol {
    var dataSource: [Movie] {get set}
    var errorPublisher: Published<ErrorMessage?>.Publisher {get}
    var moviesPublisher: Published<Bool?>.Publisher {get}
    var isLoading: Bool {get set}
    func viewDidLoad()
    func viewDidAppear()
    
    func fetchMovies()
    func getMovie(index: Int) -> Movie
}

class ComingViewModel: ComingViewModelProtocol {
    @Published private var error: ErrorMessage? = nil
    var errorPublisher: Published<ErrorMessage?>.Publisher {$error}
    
    @Published internal var isMovieFetched: Bool? = nil
    var moviesPublisher: Published<Bool?>.Publisher {$isMovieFetched}
    
    var dataSource: [Movie] = []
    var isLoading: Bool = false
    private var comingUseCase: GetComingMoviesUseCaseProtocol?
    
    
    init(useCase: GetComingMoviesUseCaseProtocol? = GetComingMoviesUseCase()) {
        self.comingUseCase = useCase
    }
    
    func viewDidLoad() {
        fetchMovies()
    }
    
    func viewDidAppear() {
        //
    }
    
    func fetchMovies() {
        isLoading = true
        comingUseCase?.execute(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieList):
                self.isMovieFetched = true
                if self.dataSource.count == 0 {
                    self.dataSource = movieList ?? []
                } else {
                    self.dataSource.append(contentsOf: movieList ?? [])
                }
                self.isLoading = false

            case .failure(let error):
                print(error)
                self.isLoading = false
                self.isMovieFetched = true
            }
        })
    }
    
    func getMovie(index: Int) -> Movie {
        return dataSource[index]
    }
    
}
