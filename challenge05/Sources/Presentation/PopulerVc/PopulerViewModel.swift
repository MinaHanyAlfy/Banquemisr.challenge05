//
//  PopulerViewModel.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation

protocol PopulerViewModelProtocol {
    var dataSource: [Movie] {get set}
    var errorPublisher: Published<ErrorMessage?>.Publisher {get}
    var moviesPublisher: Published<Bool?>.Publisher {get}
    func viewDidLoad()
    func viewDidAppear()
    
    func fetchMovies()
    func getMovie(index: Int) -> Movie
}

class PopulerViewModel: PopulerViewModelProtocol {
    @Published private var error: ErrorMessage? = nil
    var errorPublisher: Published<ErrorMessage?>.Publisher {$error}
    
    @Published internal var isMovieFetched: Bool? = nil
    var moviesPublisher: Published<Bool?>.Publisher {$isMovieFetched}
    
    var dataSource: [Movie] = []
    private var populerUseCase: GetPopulerMoviesUseCaseProtocol?
    
    
    init(useCase: GetPopulerMoviesUseCaseProtocol? = GetPopulerMoviesUseCase()) {
        self.populerUseCase = useCase
    }
    
    func viewDidLoad() {
        fetchMovies()
    }
    
    func viewDidAppear() {
        //
    }
    
    func fetchMovies() {
        populerUseCase?.execute(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieList):
                self.isMovieFetched = true
                self.dataSource = movieList ?? []
            case .failure(let error):
                print(error)
                self.isMovieFetched = true
            }
        })
    }
    
    func getMovie(index: Int) -> Movie {
        return dataSource[index]
    }
    
}
