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
    func isReachable() -> Bool
    func fetchMovies()
    func getMovie(index: Int) -> Movie
}

class ComingViewModel: ComingViewModelProtocol {
    @Published private var error: ErrorMessage? = nil
    public  var errorPublisher: Published<ErrorMessage?>.Publisher {$error}
    
    @Published internal var isMovieFetched: Bool? = nil
    public  var moviesPublisher: Published<Bool?>.Publisher {$isMovieFetched}
    
    public  var dataSource: [Movie] = []
    public  var isLoading: Bool = false
    private var comingUseCase: GetComingMoviesUseCaseProtocol?
    private let reachability = Reachability.shared
    
    public init(useCase: GetComingMoviesUseCaseProtocol? = GetComingMoviesUseCase()) {
        self.comingUseCase = useCase
    }
    
    public func viewDidLoad() {
        fetchMovies()
    }
    
    public func viewDidAppear() {
        //
    }
    
    public func fetchMovies() {
        isLoading = true
        comingUseCase?.execute(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieList):
                self.isMovieFetched = true
                if self.dataSource.count == 0 {
                    self.dataSource = movieList ?? []
                } else {
                    if !(movieList?.count == 0) {
                        self.dataSource.append(contentsOf: movieList ?? [])
                    }
                }
                self.isLoading = false      
            case .failure(let error):
                print(error)
                self.isLoading = false
                self.isMovieFetched = true
            }
        })
    }
    
    public func isReachable() -> Bool {
        return reachability.isConnectedToNetwork()
    }
    
    public func getMovie(index: Int) -> Movie {
        return dataSource[index]
    }
    
}
